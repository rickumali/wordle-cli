//
//  main.swift (swift-curses-mock1)
//
//  Created by Rick Umali on 3/5/23.
import Darwin.ncurses

var row: Int32 = 0
var col: Int32 = 0
var scr: OpaquePointer // KEY: Found type by reading initscr declaration (!)
let prompt_len: Int32 = 15

scr = initscr()
start_color()

// KEY: Read original header to get these values
init_pair(2, 0, 7) // BLACK=0, WHITE=7
init_pair(3, 0, 2) // GREEN=2
init_pair(4, 0, 3) // YELLOW=3

col = getmaxx(scr)
row = getmaxy(scr)

func updateGuessRowGuiWide(g: Int, s: String) {
    var offset: Int32 = 12
    let y: Int32 = Int32(g) + 4
    mvaddstr(y, 8, "\(g): |   |   |   |   |   |")
    for c in s.enumerated() {
        let color = Int.random(in: 0...3)
        switch(color) {
            case 0:
                attron(COLOR_PAIR(2))
                break
            case 1:
                attron(COLOR_PAIR(3))
                break
            case 2:
                attron(COLOR_PAIR(4))
                break
            default:
                break
        }
        mvaddstr(y, offset, " \(c.element) ")
        attroff(COLOR_PAIR(1))
        offset += 4
    }
}

// KEY: My original replacement for mvprintw
move(3, 3); addstr("wordle-cli (by Rick Umali)")
// KEY: Reading Darwin.ncurses shows mvaddstr() is available
// move(5, 8); addstr("1: |   |   |   |   |   |")
mvaddstr(5, 8, "1: |   |   |   |   |   |")
mvaddstr(6, 8, "2: |   |   |   |   |   |")
mvaddstr(7, 8, "3: |   |   |   |   |   |")
mvaddstr(8, 8, "4: |   |   |   |   |   |")
mvaddstr(9, 8, "5: |   |   |   |   |   |")
mvaddstr(10, 8, "6: |   |   |   |   |   |")
mvaddstr(12, 10, "Q W E R T Y U I O P")
mvaddstr(13, 11, "A S D F G H J K L")
mvaddstr(14, 12, "Z X C V B N M")

var guess_count: Int = 1
while guess_count != 7 {
    mvaddstr(16, 3, "Guess (\(guess_count) of 6)")
    mvaddstr(16, 3 + prompt_len, "         ");
    move(16, 3 + prompt_len);

    refresh()
    // KEY: This declares an empty array of 40 NULLs
    var raw_str: [CChar] = Array(repeating: CChar(0), count: 40)
    // KEY: Getting the 'address' by ampersand
    // KEY: This was lucky, and Xcode guided me somewhat
    getstr(&raw_str)
    let guessString = String(cString: raw_str)
    mvaddstr(17, 3, "Entered: \(guessString)");

    updateGuessRowGuiWide(g: guess_count, s: guessString)
    guess_count += 1
}
mvaddstr(17, 3, "That's it! Any key to quit!");

getch();
endwin();

print("row=\(row), col=\(col)")

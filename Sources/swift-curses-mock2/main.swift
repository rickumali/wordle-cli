//
//  main.swift (swift-curses-mock2 with SwiftCursesTerm)
//
//  Created by Rick Umali on 3/7/23.

import Foundation
import SwiftCursesTerm

let prompt_len = 15

var term = SwiftCursesTerm()

let green = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.green)
let yellow = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.yellow)

func updateGuessRowGuiWide(g: Int, s: String) {
    var offset: Int = 12
    let y: Int = Int(g) + 3
    term.addStrTo(content: "\(g): |   |   |   |   |   |", line: y, column: 8)
    for c in s.enumerated() {
        let color = Int.random(in: 0...3)
        switch(color) {
            case 0:
                term.resetAttributes()
                break
            case 1:
                term.setAttributes([], colorPair: green)
                break
            case 2:
                term.setAttributes([], colorPair: yellow)
                break
            default:
                break
        }
        term.addStrTo(content: " \(c.element) ", line: y, column: offset)
        term.refresh()
        term.resetAttributes()
        offset += 4
    }
}

term.addStrTo(content: "wordle-cli (by Rick Umali)", line: 3, column: 3)
term.addStrTo(content: "1: |   |   |   |   |   |", line: 5, column: 8)
term.addStrTo(content: "2: |   |   |   |   |   |", line: 6, column: 8)
term.addStrTo(content: "3: |   |   |   |   |   |", line: 7, column: 8)
term.addStrTo(content: "4: |   |   |   |   |   |", line: 8, column: 8)
term.addStrTo(content: "5: |   |   |   |   |   |", line: 9, column: 8)
term.addStrTo(content: "6: |   |   |   |   |   |", line: 10, column: 8)
term.addStrTo(content: "Q W E R T Y U I O P", line: 12, column: 10)
term.addStrTo(content: "A S D F G H J K L", line: 13, column: 11)
term.addStrTo(content: "Z X C V B N M", line: 14, column: 12)

for guessCounter in 1...6 {
    term.addStrTo(content: "Guess (\(guessCounter) of 6)", line: 16, column: 3)
    term.addStrTo(content: "         ", line: 16, column: 3 + prompt_len );
    term.move(window: nil, line: 16, column: 3 + prompt_len)

    term.refresh()
    // KEY: This declares an empty array of 40 NULLs
    var raw_str: [CChar] = Array(repeating: CChar(0), count: 40)
    // KEY: Getting the 'address' by ampersand
    // KEY: This was lucky, and Xcode guided me somewhat
    getstr(&raw_str)
    let guessString = String(cString: raw_str)
    term.addStrTo(content: "Entered: \(guessString)", line: 17, column: 3);

    updateGuessRowGuiWide(g: guessCounter, s: guessString)
}
term.addStrTo(content: "That's it! Any key to quit!", line: 17, column: 3);

term.refresh()
getch()
term.shutdown()
exit(EXIT_SUCCESS)

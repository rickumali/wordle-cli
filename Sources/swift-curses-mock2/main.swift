//
//  main.swift (swift-curses-mock2 with SwiftCursesTerm)
//
//  Created by Rick Umali on 3/7/23.

import Foundation
import SwiftCursesTerm

let prompt_len = 15

var term = SwiftCursesTerm()
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

var guess_count: Int = 1
while guess_count != 7 {
    term.addStrTo(content: "Guess (\(guess_count) of 6)", line: 16, column: 3)
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

    // updateGuessRowGuiWide(g: guess_count, s: guessString)
    guess_count += 1
}
term.addStrTo(content: "That's it! Any key to quit!", line: 17, column: 3);

term.refresh()
getch()
term.shutdown()
exit(EXIT_SUCCESS)

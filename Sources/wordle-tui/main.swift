//
//  main.swift (swift-tui)
//
//  Created by Rick Umali on 3/7/23.

import Foundation
import SwiftCursesTerm

let prompt_len = 15

class WordleCurses {
    var term: SwiftCursesTerm
    var game_title: SCTWindowId
    var guessesBoard: SCTWindowId
    var keyboardDisplay: SCTWindowId
    let green: SCTColorPair
    let yellow: SCTColorPair
    let eightySpaces: String

    init() {
        term = SwiftCursesTerm()
        game_title = term.newWindow(height: 1, width: 40, line: 3, column: 3)
        guessesBoard = term.newWindow(height: 6, width: 40, line: 5, column: 8)
        keyboardDisplay = term.newWindow(height: 3, width: 40, line: 5, column: 8)

        green = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.green)
        yellow = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.yellow)
        eightySpaces = String(repeatElement(" ", count: 80))
    }

    func updateGuessRowGuiWide(g: Int, s: String) {
        var offset: Int = 4
        let y: Int = Int(g) - 1
        term.setAttributes(window: guessesBoard, [TextAttribute.normal], colorPair: nil)
        term.addStrTo(window: guessesBoard, content: "\(g): |   |   |   |   |   |", line: y, column: 0)
        for c in s.enumerated() {
            let color = Int.random(in: 0...3)
            switch(color) {
                case 0:
                    term.setAttributes(window: guessesBoard, [TextAttribute.normal], colorPair: nil)
                    break
                case 1:
                    term.setAttributes(window: guessesBoard, [], colorPair: green)
                    break
                case 2:
                    term.setAttributes(window: guessesBoard, [], colorPair: yellow)
                    break
                default:
                    break
            }
            term.addStrTo(window: guessesBoard, content: " \(c.element) ", line: y, column: offset)
            term.setAttributes(window: guessesBoard, [TextAttribute.normal], colorPair: nil)
            offset += 4
        }
        term.refresh(window: guessesBoard)
    }

    func draw() {
        term.addStr(window: game_title, content: "wordle-cli (by Rick Umali)", refresh: true)
        term.addStrTo(window: guessesBoard, content: "1: |   |   |   |   |   |", line: 0, column: 0)
        term.addStrTo(window: guessesBoard, content: "2: |   |   |   |   |   |", line: 1, column: 0)
        term.addStrTo(window: guessesBoard, content: "3: |   |   |   |   |   |", line: 2, column: 0)
        term.addStrTo(window: guessesBoard, content: "4: |   |   |   |   |   |", line: 3, column: 0)
        term.addStrTo(window: guessesBoard, content: "5: |   |   |   |   |   |", line: 4, column: 0)
        term.addStrTo(window: guessesBoard, content: "6: |   |   |   |   |   |", line: 5, column: 0, refresh: true)
        term.addStrTo(content: "Q W E R T Y U I O P", line: 12, column: 10)
        term.addStrTo(content: "A S D F G H J K L", line: 13, column: 11)
        term.addStrTo(content: "Z X C V B N M", line: 14, column: 12)
    }

    func prompt(g: Int) -> String {
        // KEY: This declares an empty array of 40 NULLs
        var raw_str: [CChar] = Array(repeating: CChar(0), count: 40)
        var guessString: String
        var goodInput: Bool

        goodInput = false
        repeat {
            term.addStrTo(content: "Guess (\(g) of 6)", line: 16, column: 3)
            term.addStrTo(content: String(eightySpaces.suffix(80 - (3 + prompt_len))), line: 16, column: 3 + prompt_len);
            term.move(window: nil, line: 16, column: 3 + prompt_len)
    
            term.refresh()
            // KEY: Getting the 'address' by ampersand
            // KEY: This was lucky, and Xcode guided me somewhat
            getstr(&raw_str)
            guessString = String(cString: raw_str)
            if guessString.count == 5 {
                goodInput = true
                term.addStrTo(content: eightySpaces, line: 17, column: 3);
                term.refresh()
            } else {
                term.addStrTo(content: "You need a five letter word!", line: 17, column: 3);
            }
        } while !goodInput
        term.addStrTo(content: "Entered: \(guessString)", line: 17, column: 3);
        return guessString
    }
}

// New Main
var wordle_tui = WordleCurses()

wordle_tui.draw()

for guessCounter in 1...6 {
    var guessString: String
    guessString = wordle_tui.prompt(g: guessCounter)
    wordle_tui.updateGuessRowGuiWide(g: guessCounter, s: guessString)
}

// term.addStrTo(content: "That's it! Any key to quit!", line: 17, column: 3);
// term.refresh()

getch()
// term.shutdown()
exit(EXIT_SUCCESS)

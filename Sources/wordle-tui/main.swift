//
//  main.swift (swift-tui)
//
//  Created by Rick Umali on 3/7/23.

import Foundation
import SwiftCursesTerm
import wordle

class WordleCurses {
    let prompt_len = 15
    var term: SwiftCursesTerm

    let eightySpaces: String
    var game_title: SCTWindowId
    var guessesBoard: SCTWindowId
    var keyboardDisplay: SCTWindowId

    let green: SCTColorPair
    let yellow: SCTColorPair

    init() {
        term = SwiftCursesTerm()
        term.refresh()

        eightySpaces = String(repeatElement(" ", count: 80))
        game_title = term.newWindow(height: 1, width: 40, line: 3, column: 3)
        guessesBoard = term.newWindow(height: 6, width: 40, line: 5, column: 8)
        keyboardDisplay = term.newWindow(height: 3, width: 40, line: 5, column: 8)

        green = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.green)
        yellow = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.yellow)
    }


    func updateGuessRow(g: Int, s: GuessRow) {
        var offset: Int = 4
        let y: Int = Int(g) - 1
        term.setAttributes(window: guessesBoard, [TextAttribute.normal], colorPair: nil)
        term.addStrTo(window: guessesBoard, content: "\(g): |   |   |   |   |   |", line: y, column: 0)
        for c in s.letterWithColor() {
            let (letter, color) = c
            switch(color) {
                case "NONE":
                    term.setAttributes(window: guessesBoard, [TextAttribute.normal], colorPair: nil)
                    break
                case "GREEN":
                    term.setAttributes(window: guessesBoard, [], colorPair: green)
                    break
                case "YELLOW":
                    term.setAttributes(window: guessesBoard, [], colorPair: yellow)
                    break
                default:
                    break
            }
            term.addStrTo(window: guessesBoard, content: " \(letter) ", line: y, column: offset)
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
        term.addStrTo(content: "Guess (\(g) of 6)", line: 16, column: 3)
        term.addStrTo(content: String(eightySpaces.suffix(80 - (3 + prompt_len))), line: 16, column: 3 + prompt_len);
        term.move(window: nil, line: 16, column: 3 + prompt_len)
        term.refresh()

        // KEY: This declares an empty array of 40 NULLs
        var raw_str: [CChar] = Array(repeating: CChar(0), count: 40)
        getstr(&raw_str)
        return String(cString: raw_str)
    }

    /// updateStatus()
    /// If s is nil, the status line is cleared, otherwise it displays s
    func updateStatus(s: String? = nil) {
        if let s = s {
            term.addStrTo(content: s, line: 17, column: 3);
        } else {
            term.addStrTo(content: eightySpaces, line: 17, column: 3);
        }
    }

    func close(s: String? = nil) {
        if let s = s {
            updateStatus(s: s)
        } else {
            updateStatus(s: "That's it! (Any key to quit!)")
        }
        term.refresh()
        getch()
        term.shutdown()
    }
}

// New Main

var wordleWords = WordleWords()
try wordleWords.load()
/// This variable contains the correct word
var correctWord: String = wordleWords.getRandomCorrectWord()

var prevGuessRows: [GuessRow] = []

var game: WordleCurses = WordleCurses()

game.draw()

for guessCounter in 1...6 {
    var guessString: String
    var goodInput = false
    repeat {
        guessString = game.prompt(g: guessCounter)
        // TODO: Consider making "aeiou" the backdoor
        let backdoorNum = Int(guessString) ?? 0
        if backdoorNum == -99 {
            game.updateStatus(s: "Pssst: \(correctWord.uppercased())")
            continue
        }
        if guessString.count == 5 {
            if wordleWords.valid(guessString.lowercased()) {
                goodInput = true
                game.updateStatus()
            } else {
                game.updateStatus(s: "Your word is not in my dictionary!")
            }
        } else {
            game.updateStatus(s: "You need a five letter word!")
        }
    } while !goodInput
    let guessRow = GuessRow(guess: guessString.uppercased())
    guessRow.updateRow(correctWord: correctWord.uppercased())
    prevGuessRows.append(guessRow)
    game.updateGuessRow(g: guessCounter, s: guessRow)
    if guessRow.matchesCorrectWord() {
        // TODO: Add fancy message here
        game.close(s: "You got it in \(guessCounter) guess\(guessCounter > 1 ? "es" : "")! (Any key to quit.)")
        break
    }
    if guessCounter == 6 {
        game.close(s: "The correct word was \(correctWord.uppercased()) (Any key to quit.)")
        break
    }
}
exit(EXIT_SUCCESS)

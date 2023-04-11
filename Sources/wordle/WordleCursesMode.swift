//
//  WordleCursesMode.swift
//
//  Created by Rick Umali on 3/24/23.
//

import Foundation
import SwiftCursesTerm

public class WordleCursesMode: GameView {
    let prompt_len = 15
    var term: SwiftCursesTerm
    var keyboardRow: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]

    let eightySpaces: String
    var game_title: SCTWindowId
    var guessesBoard: SCTWindowId
    var keyboardDisplay: SCTWindowId

    let green: SCTColorPair
    let yellow: SCTColorPair

    var game: WordleGameModel

    public init(game: WordleGameModel) {
        self.game = game

        term = SwiftCursesTerm()
        term.refresh()

        eightySpaces = String(repeatElement(" ", count: 80))
        game_title = term.newWindow(height: 1, width: 40, line: 3, column: 3)
        guessesBoard = term.newWindow(height: 6, width: 40, line: 5, column: 8)
        keyboardDisplay = term.newWindow(height: 3, width: 40, line: 12, column: 5)

        green = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.green)
        yellow = term.defineColorPair(foreground: CursesColor.black, background: CursesColor.yellow)
    }

    public func drawNewGuess() {
        let g: [GuessRow] = self.game.guessesAry
        if g.count == 0 {
            return
        }
        var offset: Int = 4
        let y: Int = g.count - 1
        let s: GuessRow = g.last!
        term.setAttributes(window: guessesBoard, [TextAttribute.normal], colorPair: nil)
        term.addStrTo(window: guessesBoard, content: "\(y + 1): |   |   |   |   |   |", line: y, column: 0)
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
        drawKeyboard()
    }

    public func draw() {
        term.addStr(window: game_title, content: "wordle-cli (by Rick Umali)", refresh: true)
        term.addStrTo(window: guessesBoard, content: "1: |   |   |   |   |   |", line: 0, column: 0)
        term.addStrTo(window: guessesBoard, content: "2: |   |   |   |   |   |", line: 1, column: 0)
        term.addStrTo(window: guessesBoard, content: "3: |   |   |   |   |   |", line: 2, column: 0)
        term.addStrTo(window: guessesBoard, content: "4: |   |   |   |   |   |", line: 3, column: 0)
        term.addStrTo(window: guessesBoard, content: "5: |   |   |   |   |   |", line: 4, column: 0)
        term.addStrTo(window: guessesBoard, content: "6: |   |   |   |   |   |", line: 5, column: 0, refresh: true)
        drawKeyboard();
    }

    func drawKeyboard() {
        for (row, keyrow) in keyboardRow.enumerated() {
            var kString: String = ""
            var offset: Int = 0
            for k in keyrow {
                if (self.game.usedLettersAry.firstIndex(of: String(k)) == nil) {
                    kString += " \(k) "
                } else {
                    kString += "_\(k)_"
                }
                term.addStrTo(window: keyboardDisplay, content: kString, line: row, column: row + offset)
            }
        }
        term.refresh(window: keyboardDisplay)
    }

    public func prompt(g: Int) -> String {
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
    public func updateStatus(s: String? = nil) {
        if let s = s {
            term.addStrTo(content: s, line: 17, column: 3);
        } else {
            term.addStrTo(content: eightySpaces, line: 17, column: 3);
        }
    }

    public func close(s: String? = nil) {
        if let s = s {
            updateStatus(s: s + " (Any key to quit.)")
        } else {
            updateStatus(s: "That's it! (Any key to quit!)")
        }
        term.refresh()
        getch()
        term.shutdown()
    }
}

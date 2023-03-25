//
//  main.swift (swift-tui)
//
//  Created by Rick Umali on 3/7/23.

import Foundation
import wordle

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
    game.drawNewGuess(g: prevGuessRows)
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

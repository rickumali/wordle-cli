//
//  WordleGameModel.swift
//
//  Created by Rick Umali on 3/27/23.

import Foundation

public class WordleGameModel {
    var guesses: [GuessRow]
    public var guessesAry: [GuessRow] {
        return guesses
    }
    var correctWord: String
    var usedLetters: [String]
    public var usedLettersAry: [String] {
        return usedLetters
    }
    let allowedGuesses = 6
    public var promptGuessCount: Int {
        return guesses.count + 1
    }
    public var guessCount: Int {
        return guesses.count
    }

    public init(correctWord s: String) {
        correctWord = s
        guesses = []
        usedLetters = []
    }

    public func isFinished() -> Bool {
        if guesses.count == 0 {
            return false
        }
        if isWon() {
            return true
        }
        if guesses.count == allowedGuesses {
            return true
        }
        return false
    }

    public func isWon() -> Bool {
        let s: GuessRow? = guesses.last
        if s == nil {
            return false
        }
        if s!.matchesCorrectWord() {
            return true
        }
        return false
    }

    public func addNewGuess(_ s: String) {
        let guessRow = GuessRow(guess: s.uppercased())
        guessRow.updateRow(correctWord: correctWord.uppercased())
        guesses.append(guessRow)
        for c in s.uppercased() {
            if (usedLetters.firstIndex(of: String(c)) == nil) {
                usedLetters.append(String(c))
            }
        }
    }

    public func endMessage() -> String {
        let guessCount = guesses.count
        switch guessCount {
        case 1:
            return "Amazing! You got in 1 guess!"
        case 2:
            return "Wow! Two guesses!"
        case 3:
            return "Great! You got in 3 guesses!"
        case 4:
            return "Fantastic! Four guesses!"
        case 5:
            return "Good work! Five guesses."
        case 6:
            return "Whew! On the last (6th) guess!"
        default:
            return "You got it!"
        }
    }

}

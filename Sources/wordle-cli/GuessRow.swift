//
//  GuessRow.swift
//
//  Created by Rick Umali on 2/18/23.
//

class GuessRow {
    var guessLetters: [Letter] = []

    init(guess s: String) {
        for c in s {
            guessLetters.append(Letter(myLetter: c))
        }
    }

    func row() -> String {
        var str = "|"
        for c in guessLetters {
            str += c.letterWithStatus() + "|"
        }
        return str
    }
}

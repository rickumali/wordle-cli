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

    func updateRow(correctWord s: String) {
        var remainingLetters: [Character] = []
        for (i, c) in guessLetters.enumerated() {
            let idx1 = String.Index(utf16Offset: i, in: s)
            if c.char == s[idx1] {
                c.inWord = true
                c.inCorrectSpot = true
            } else {
                remainingLetters.append(s[idx1])
            }
        }
    }
}

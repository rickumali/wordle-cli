//
//  GuessRow.swift
//
//  Created by Rick Umali on 2/18/23.
//

public class GuessRow {
    var guessLetters: [Letter] = []

    public init(guess s: String) {
        for c in s {
            guessLetters.append(Letter(myLetter: c))
        }
    }

    public func row() -> String {
        var str = "|"
        for c in guessLetters {
            str += c.letterWithStatus() + "|"
        }
        return str
    }

    public func letterWithColor() -> [(String, String)] {
        var letterStats : [(String, String)] = []
        for c in guessLetters {
            var stat: String
            if c.inCorrectSpot {
                stat = "GREEN"
            } else if c.inWord {
                stat = "YELLOW"
            } else {
                stat = "NONE"
            }
            letterStats.append((String(c.char), stat))
        }
        return letterStats
    }

    // TODO: Consider putting updateRow() inside of matchesCorrectWord function
    public func updateRow(correctWord s: String) {
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

        for c in guessLetters {
            if c.inCorrectSpot != true {
                if let idx = remainingLetters.firstIndex(of: c.char) {
                    c.inWord = true
                    c.inCorrectSpot = false
                    remainingLetters.remove(at: idx)
                }
            }
        }
    }

    /// matchesCorrectWord() - Returns TRUE if the GuessRow
    /// matches the correct word, otherwise FALSE. The updateRow()
    /// function must be called before this gives an accurate value
    public func matchesCorrectWord() -> Bool {
        for c in guessLetters {
            if !c.inCorrectSpot {
                return false
            }
        }
        return true
    }
}

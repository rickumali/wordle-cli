print("wordle-cli by Rick Umali")

import Foundation

func corectWordMessage(guessCount: Int) {
    switch guessCount {
    case 1:
        print("Amazing! You got in 1 guess!")
    case 2:
        print("Wow! Two guesses!")
    case 3:
        print("Great! You got in 3 guesses!")
    case 4:
        print("Fantastic! Four guesses!")
    case 5:
        print("Good work! Five guesses.")
    case 6:
        print("Whew! On the last (6th) guess!")
    default:
        print("You got it!")
    }
}

var wordleWords = WordleWords()
try wordleWords.load()

/// This variable holds the guess from the user
var guess: String
/// This variable tracks whether input is 5 letters or not
var goodInput: Bool
/// This variable contains the correct word
var correctWord: String = wordleWords.getRandomCorrectWord()
/// This variable contains previous guesses
var prevGuessRows: [GuessRow] = []

for guessCounter in 1...6 {
    goodInput = false
    // TODO: Consider making this repeat/while a function
    repeat {
        print("Guess (\(guessCounter) out of 6)?", terminator: " ")
        guess = readLine()!
        // TODO: Consider making "aeiou" the backdoor
        let backdoorNum = Int(guess) ?? 0
        if backdoorNum == -99 {
            print("Pssst: \(correctWord.uppercased())")
            continue
        }
        if guess.count == 5 {
            if wordleWords.valid(guess.lowercased()) {
                goodInput = true
            } else {
                print("Your word is not in my dictionary!")
            }
        } else {
            print("You need a five letter word!")
        }
    } while !goodInput
    let guessRow = GuessRow(guess: guess.uppercased())
    guessRow.updateRow(correctWord: correctWord.uppercased())
    prevGuessRows.append(guessRow)
    for (c, r) in prevGuessRows.enumerated() {
        print("\(c + 1):", terminator: " ")
        print(r.row())
    }
    if guessRow.matchesCorrectWord() {
        corectWordMessage(guessCount: guessCounter)
        break
    }
    if guessCounter == 6 {
        print("The correct word was \(correctWord.uppercased())")
        break
    }
}

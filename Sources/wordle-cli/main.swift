print("wordle-cli by Rick Umali")

import Foundation

/// TODO: Make this interact with dictionary
func getCorrectWord() -> String {
    return ProcessInfo.processInfo.environment["PUZZLE_WORD"] ?? "aroma"
}

/// This variable holds the guess from the user
var guess: String
/// This variable tracks whether input is 5 letters or not
var goodInput: Bool
/// This variable contains the correct word
var correctWord: String = getCorrectWord()
/// This variable contains previous guesses
var prevGuessRows: [GuessRow] = []

for guessCounter in 1...6 {
    goodInput = false
    // TODO: Consider making this repeat/while a function
    repeat {
        print("Guess (\(guessCounter) out of 6)?", terminator: " ")
        guess = readLine()!
        if guess.count == 5 {
            goodInput = true
        } else {
            print("You need a five letter word!")
        }
    } while !goodInput
    let guessRow = GuessRow(guess: guess.uppercased())
    // TODO: Check guess in dictionary
    guessRow.updateRow(correctWord: correctWord.uppercased())
    prevGuessRows.append(guessRow)
    for (c, r) in prevGuessRows.enumerated() {
        print("\(c + 1):", terminator: " ")
        print(r.row())
    }
    if guessRow.matchesCorrectWord() {
        // TODO: Make this a function. Cool message per value
        print("You got it in \(guessCounter) guesses")
        break
    }
    if guessCounter == 6 {
        print("The correct word was \(correctWord.uppercased())")
        break
    }
}

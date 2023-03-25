import Foundation
import wordle

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

var gameView: GameView = WordleLineMode()
// var game: GameView = WordleCursesMode()

gameView.draw()

for guessCounter in 1...6 {
    goodInput = false
    repeat {
        guess = gameView.prompt(g: guessCounter)
        let backdoorNum = Int(guess) ?? 0
        if backdoorNum == -99 {
            gameView.updateStatus(s: "Pssst: \(correctWord.uppercased())")
            continue
        }
        if guess.count == 5 {
            if wordleWords.valid(guess.lowercased()) {
                goodInput = true
            } else {
                gameView.updateStatus(s: "Your word is not in my dictionary!")
            }
        } else {
            gameView.updateStatus(s: "You need a five letter word!")
        }
    } while !goodInput
    let guessRow = GuessRow(guess: guess.uppercased())
    guessRow.updateRow(correctWord: correctWord.uppercased())
    prevGuessRows.append(guessRow)
    gameView.drawNewGuess(g: prevGuessRows)
    if guessRow.matchesCorrectWord() {
        // TODO: Add fancy message here
        // corectWordMessage(guessCount: guessCounter)
        gameView.close(s: "You got it in \(guessCounter) guess\(guessCounter > 1 ? "es" : "")!")
        break
    }
    if guessCounter == 6 {
        gameView.close(s: "The correct word was \(correctWord.uppercased())")
        break
    }
}

import Foundation
import wordle

var wordleWords = WordleWords()
try wordleWords.load()

/// This variable holds the guess from the user
var guess: String
/// This variable tracks whether input is 5 letters or not
var goodInput: Bool
/// This variable contains the correct word
var correctWord: String = wordleWords.getRandomCorrectWord()

/// This variable holds the Game Model
var game: WordleGameModel = WordleGameModel(correctWord: correctWord)

var gameView: GameView!

if CommandLine.argc == 2 {
    if CommandLine.arguments[1] == "--line-mode" {
        gameView = WordleLineMode(game: game)
    } else if CommandLine.arguments[1] == "--curses-mode" {
        gameView = WordleCursesMode(game: game)
    } else {
        print("Usage: wordle-cli [--line-mode|--curses-mode]")
        exit(EXIT_FAILURE)
    }
} else if CommandLine.argc == 1 {
    gameView = WordleCursesMode(game: game)
}

gameView.draw()

while !game.isFinished() {
    goodInput = false
    repeat {
        guess = gameView.prompt(g: game.promptGuessCount)
        let backdoorNum = Int(guess) ?? 0
        if backdoorNum == -99 {
            gameView.updateStatus(s: "Pssst: \(correctWord.uppercased())")
            continue
        }
        if guess.count == 5 {
            if wordleWords.valid(guess) {
                goodInput = true
            } else {
                gameView.updateStatus(s: "Your word is not in my dictionary!")
            }
        } else {
            gameView.updateStatus(s: "You need a five letter word!")
        }
    } while !goodInput
    game.addNewGuess(guess)
    gameView.drawNewGuess()
}
if (game.isWon()) {
    gameView.close(s: game.endMessage())
} else {
    gameView.close(s: "The correct word was \(correctWord.uppercased())")
}

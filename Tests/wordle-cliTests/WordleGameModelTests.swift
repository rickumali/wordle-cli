//
//  WordleGameModelTests.swift
//
//  Created by Rick Umali on 3/28/23.

import XCTest
@testable
import wordle

class WordleGameModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateWordleGameModel() {
        let game = WordleGameModel(correctWord: "taser")
        XCTAssertEqual(game.correctWord, "taser")
        XCTAssertEqual(game.guesses.count, 0)
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
    }

    func testAromaGame() {
        let game = WordleGameModel(correctWord: "aroma")
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        game.addNewGuess("cured")
        XCTAssertEqual(game.guessesAry.last!.row(), "| C | U |-R-| E | D |")
        XCTAssertEqual(game.guesses.count, 1)
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        game.addNewGuess("walks")
        XCTAssertEqual(game.guessesAry.last!.row(), "| W |-A-| L | K | S |")
        XCTAssertEqual(game.guesses.count, 2)
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        game.addNewGuess("tramp")
        XCTAssertEqual(game.guessesAry.last!.row(), "| T |+R+|-A-|+M+| P |")
        XCTAssertEqual(game.guesses.count, 3)
        game.addNewGuess("aroma")
        XCTAssertEqual(game.guessesAry.last!.row(), "|+A+|+R+|+O+|+M+|+A+|")
        XCTAssertEqual(game.guesses.count, 4)
        XCTAssertEqual(game.guessCount, 4)
        XCTAssertEqual(game.promptGuessCount, 5)
        XCTAssertTrue(game.isFinished())
        XCTAssertTrue(game.isWon())
    }

    func testCrazeGame() {
        let game = WordleGameModel(correctWord: "craze")
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        XCTAssertEqual(game.promptGuessCount, 1)
        game.addNewGuess("grail") // Guess 1
        XCTAssertEqual(game.guesses.last!.row(), "| G |+R+|+A+| I | L |")
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        XCTAssertEqual(game.promptGuessCount, 2)
        game.addNewGuess("track") // Guess 2
        XCTAssertEqual(game.guesses.last!.row(), "| T |+R+|+A+|-C-| K |")
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        XCTAssertEqual(game.promptGuessCount, 3)
        game.addNewGuess("cramp") // Guess 3
        XCTAssertEqual(game.guesses.last!.row(), "|+C+|+R+|+A+| M | P |")
        XCTAssertEqual(game.promptGuessCount, 4)
        game.addNewGuess("crabs") // Guess 4
        XCTAssertEqual(game.guesses.last!.row(), "|+C+|+R+|+A+| B | S |")
        XCTAssertEqual(game.promptGuessCount, 5)
        game.addNewGuess("crazy") // Guess 5
        XCTAssertEqual(game.guesses.last!.row(), "|+C+|+R+|+A+|+Z+| Y |")
        XCTAssertEqual(game.promptGuessCount, 6)
        game.addNewGuess("craze") // Guess 6 Last guess!
        XCTAssertEqual(game.guesses.last!.row(), "|+C+|+R+|+A+|+Z+|+E+|")
        XCTAssertTrue(game.isFinished())
        XCTAssertTrue(game.isWon())
        XCTAssertEqual(game.promptGuessCount, 7)
        XCTAssertEqual(game.guessCount, 6)
    }
}

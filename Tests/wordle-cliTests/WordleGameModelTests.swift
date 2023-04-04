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
        XCTAssertEqual(game.guesses.last!.row(), "| C | U |-R-| E | D |")
        XCTAssertEqual(game.guesses.count, 1)
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        game.addNewGuess("walks")
        XCTAssertEqual(game.guesses.last!.row(), "| W |-A-| L | K | S |")
        XCTAssertEqual(game.guesses.count, 2)
        XCTAssertFalse(game.isFinished())
        XCTAssertFalse(game.isWon())
        game.addNewGuess("tramp")
        XCTAssertEqual(game.guesses.last!.row(), "| T |+R+|-A-|+M+| P |")
        XCTAssertEqual(game.guesses.count, 3)
        game.addNewGuess("aroma")
        XCTAssertEqual(game.guesses.last!.row(), "|+A+|+R+|+O+|+M+|+A+|")
        XCTAssertEqual(game.guesses.count, 4)
        XCTAssertTrue(game.isFinished())
        XCTAssertTrue(game.isWon())
    }
}

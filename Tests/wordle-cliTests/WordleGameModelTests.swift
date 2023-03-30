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

}

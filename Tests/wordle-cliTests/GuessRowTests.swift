//
//  GuessRowTests.swift
//
//  Created by Rick Umali on 2/18/23.
//

import XCTest
@testable
import wordle_cli

class GuessRowTests: XCTestCase {
    func testCreateGuessRow() {
        var row: GuessRow = GuessRow(guess: "hello")
        XCTAssert(row.guessLetters[0].char.isLetter)
    }

    func testRowInitial() {
        let guess: GuessRow = GuessRow(guess: "catch")
        XCTAssertEqual(guess.row(), "| C | A | T | C | H |")
    }
}

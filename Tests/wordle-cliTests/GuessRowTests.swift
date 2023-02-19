//
//  GuessRowTests.swift
//
//  Created by Rick Umali on 2/18/23.
//

import XCTest
import wordle_cli

class GuessRowTests: XCTestCase {
    func testCreateGuessRow() {
        var row: GuessRow = GuessRow(guess: "hello")
        XCTAssert(row.guessLetters[0].char.isLetter)
    }
}

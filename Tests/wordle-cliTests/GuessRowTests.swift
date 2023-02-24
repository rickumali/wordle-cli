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
        let row: GuessRow = GuessRow(guess: "hello")
        XCTAssert(row.guessLetters[0].char.isLetter)
    }

    func testRowInitial() {
        let guess: GuessRow = GuessRow(guess: "catch")
        XCTAssertEqual(guess.row(), "| C | A | T | C | H |")
    }

    func testRowWithLetterUpdates() {
        let guess: GuessRow = GuessRow(guess: "taser")
        guess.guessLetters[0].inWord = true
        guess.guessLetters[0].inCorrectSpot = true
        guess.guessLetters[4].inWord = true
        XCTAssertEqual(guess.row(), "|+T+| A | S | E |-R-|")
    }

    func testUpdateRowCraze() {
        let guess: GuessRow = GuessRow(guess: "crabs")
        guess.updateRow(correctWord: "craze")
        XCTAssertEqual(guess.row(), "|+C+|+R+|+A+| B | S |")
    }

    func testUpdateRowFirstGuessLucky() {
        let guess: GuessRow = GuessRow(guess: "plant")
        guess.updateRow(correctWord: "plant")
        XCTAssertEqual(guess.row(), "|+P+|+L+|+A+|+N+|+T+|")
    }

    func testUpdateRowFirstGuessNoLetters() {
        let guess: GuessRow = GuessRow(guess: "click")
        guess.updateRow(correctWord: "taser")
        XCTAssertEqual(guess.row(), "| C | L | I | C | K |")
    }
}

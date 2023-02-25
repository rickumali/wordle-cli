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
        XCTAssertTrue(guess.matchesCorrectWord())
    }

    func testUpdateRowFirstGuessNoLetters() {
        let guess: GuessRow = GuessRow(guess: "click")
        guess.updateRow(correctWord: "taser")
        XCTAssertEqual(guess.row(), "| C | L | I | C | K |")
        XCTAssertFalse(guess.matchesCorrectWord())
    }

    func testUpdateRowAroma() {
        let guess: GuessRow = GuessRow(guess: "walks")
        guess.updateRow(correctWord: "aroma")
        XCTAssertEqual(guess.row(), "| W |-A-| L | K | S |")
    }

    func testUpdateRowAromaTwoOne() {
        let guess: GuessRow = GuessRow(guess: "tramp")
        guess.updateRow(correctWord: "aroma")
        XCTAssertEqual(guess.row(), "| T |+R+|-A-|+M+| P |")
    }

    func testUpdateRowBatonFour() {
        let guess: GuessRow = GuessRow(guess: "about")
        guess.updateRow(correctWord: "baton")
        XCTAssertEqual(guess.row(), "|-A-|-B-|-O-| U |-T-|")
    }

    func testUpdateRowPalindrome() {
        let guess: GuessRow = GuessRow(guess: "abcde")
        guess.updateRow(correctWord: "edbac")
        XCTAssertEqual(guess.row(), "|-A-|-B-|-C-|-D-|-E-|")
    }
}

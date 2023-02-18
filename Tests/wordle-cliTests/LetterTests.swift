//
//  LetterTests.swift
//  
//
//  Created by Rick Umali on 2/15/23.
//

import XCTest
import wordle_cli

class LetterTests: XCTestCase {

    func testThatLetterIsALetter() throws {
        let myLetter = Letter(myLetter: "C")
        XCTAssertTrue(myLetter.char.isLetter)
    }

    func testThatLetterHasDefaultProps() throws {
        let myLetter = Letter(myLetter: "g")
        XCTAssertFalse(myLetter.inWord)
        XCTAssertFalse(myLetter.inCorrectSpot)
    }

    func testDefaultLetterStatus() throws {
        let myLetter = Letter(myLetter: "k")
        XCTAssert(myLetter.letterWithStatus() == " K ")
    }

}

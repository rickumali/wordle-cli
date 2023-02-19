//
//  GuessRow.swift
//
//  Created by Rick Umali on 2/18/23.
//

public class GuessRow {
    public var guessLetters: [Letter] = []

    public init(guess s: String) {
        for c in s {
            guessLetters.append(Letter(myLetter: c))
        }
    }
}

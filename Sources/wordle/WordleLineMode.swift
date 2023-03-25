//
//  WordleLineMode.swift
//  
//  Created by Rick Umali on 3/24/23.

import Foundation

public class WordleLineMode {
    public init() {
        // Unused
    }

    public func drawNewGuess(g: [GuessRow]) {
        for (c, r) in g.enumerated() {
            print("\(c + 1):", terminator: " ")
            print(r.row())
        }
    }

    public func draw() {
        print("wordle-cli (by Rick Umali)")
    }

    public func prompt(g: Int) -> String {
        print("Guess (\(g) out of 6)?", terminator: " ")
        return(readLine()!)
    }

    public func updateStatus(s: String? = nil) {
        if let s = s {
            print(s)
        }
    }

    public func close(s: String? = nil) {
        if let s = s {
            print(s)
        }
    }
}


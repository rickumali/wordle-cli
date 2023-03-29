//
//  File.swift
//
//  Created by Rick Umali on 2/27/23.
//

import Foundation

public class WordleWords {
    var words: Set<String>

    public init() {
        words = []
    }

    public func getRandomCorrectWord() -> String {
        if (ProcessInfo.processInfo.environment["PUZZLE_WORD"] != nil) {
            return ProcessInfo.processInfo.environment["PUZZLE_WORD"]!
        } else {
            return words.randomElement()!
        }
    }

    public func load() throws {
        let home = URL(fileURLWithPath: NSHomeDirectory())
        let url = home.appendingPathComponent("Projects/wordle-cli/valid-wordle-words.txt")
        let file = try String(contentsOf: url)
        file.enumerateLines { (line, shouldContinue) in
            self.words.insert(line)
        }
    }

    public func valid(_ w: String) -> Bool {
        return self.words.contains(w.lowercased())
    }
}

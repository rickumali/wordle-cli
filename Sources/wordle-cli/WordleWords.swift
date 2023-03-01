//
//  File.swift
//
//  Created by Rick Umali on 2/27/23.
//

import Foundation

class WordleWords {
    init() {
    }

    func getRandomCorrectWord() -> String {
        return ProcessInfo.processInfo.environment["PUZZLE_WORD"] ?? "aroma"
    }

    func load() throws {
        let home = URL(fileURLWithPath: NSHomeDirectory())
        let url = home.appendingPathComponent("Projects/wordle-cli/valid-wordle-words.txt")
        let file = try String(contentsOf: url)
        file.enumerateLines { (line, shouldContinue) in
            print(line)
        }
    }
}

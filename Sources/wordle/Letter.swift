//
//  Letter.swift
//
//  Created by Rick Umali on 2/15/23.
//

import Foundation

class Letter {
    var char: Character
    var inWord: Bool = false
    var inCorrectSpot: Bool = false

    init(myLetter c: Character) {
        char = c
    }

    func letterWithStatus() -> String {
        var surroundChar = " "
        if inWord && inCorrectSpot {
          surroundChar = "+"
        }
        if inWord && !inCorrectSpot {
          surroundChar = "-"
        }
        if !inWord && !inCorrectSpot {
          surroundChar = " "
        }
        if !inWord && inCorrectSpot {
          // Non-sense situation
          surroundChar = " "
        }
        return surroundChar + String(char).uppercased() + surroundChar
    }
}

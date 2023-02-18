//
//  Letter.swift
//
//  Created by Rick Umali on 2/15/23.
//

import Foundation

public class Letter {
    public var char: Character
    public var inWord: Bool = false
    public var inCorrectSpot: Bool = false

    public init(myLetter c: Character) {
        char = c
    }
}

//
//  GameView.swift
//
//  Created by Rick Umali on 3/24/23.

import Foundation

public protocol GameView {
    func draw()
    func drawNewGuess(game: WordleGameModel)
    func prompt(g: Int) -> String
    func updateStatus(s: String?)
    func close(s: String?)
}

//
//  Player.swift
//  BetterTicTacToe
//
//  Created by Jonathon Day on 12/19/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Player {
    let name: String
    var wins = [Board]()
    var losses = [Board]()
    var draw = [Board]()
    
    
    func addGame(board: Board, winner: Winner) {
        switch winner {
        case .win:
            wins.append(board)
        case .loss:
            losses.append(board)
        case .draw:
            draw.append(board)
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

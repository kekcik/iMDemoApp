//
//  Game.swift
//  demoiM
//
//  Created by Иван Трофимов on 29.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation

class Constants {
    static var players = [String]()
    static var game = false
    static var counter : Int = 0
    static var currentPlayer : Int = 0
    static func p (a : Int) -> String {
        return players[a]
    }
    static func step() {
        currentPlayer += 1
        currentPlayer %= players.count
    }
    
    //MARK: - need enum
    //pre: player -- uuidString current player
    //post: 0 -- game isn't started 
    //      1 -- curent's player step 
    //      2 -- non current's player step
    
    static func status(player : String) -> Int {
        if !game {return 0}
        return player == players[currentPlayer] ? 1 : 2
    }
    
    static func startGameFor(playersInit : [UUID]) {
        game = true;
        players.removeAll()
        counter = 0
        for p in playersInit {
            players += [p.uuidString]
        }
    }
}

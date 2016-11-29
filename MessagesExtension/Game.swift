//
//  Game.swift
//  demoiM
//
//  Created by Иван Трофимов on 29.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation

class Constants {
    
    private static var players = [String]()
    private static var game = false
    private static var counter : Int = 0
    private static var currentPlayer : Int = 0

    //pre: player -- uuidString curretn player 
    //post: true -- step is success
    //      false -- step if failed
    static func step(player : String) -> Bool {
        if players[currentPlayer] != player {return false}
        currentPlayer += 1
        currentPlayer %= players.count
        return true
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
    
    static func startGameFor(playerInit: String, playersInit : [UUID]) {
        game = true;
        players.removeAll()
        counter = 0
        players += [playerInit]
        for p in playersInit {
            players += [p.uuidString]
        }
    }
}

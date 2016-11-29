//
//  Game.swift
//  demoiM
//
//  Created by Иван Трофимов on 29.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation
import Messages

class Constants {
    
    private static var players = [String]()
    private static var game = false
    private static var counter : Int = 0
    private static var currentPlayer : Int = 0
    private static var adminPlayer : Int = 0
    private static var lastMessage : MSMessage?
    
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
    //post:-1 -- game isn't started
    //      0 -- time for create numbers
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
    
    static func saveMessage(message: MSMessage){
        lastMessage = message
    }
    
    static func getMessage() -> (Bool, MSMessage?) {
        if lastMessage == nil {
            return (false, nil)
        } else {
            return (true, lastMessage)
        }
    }
    
}

//
//  Game.swift
//  demoiM
//
//  Created by Иван Трофимов on 29.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation
import Messages

class Game {
    /*\
     0 -- нет игры
     1 -- предложение игры
     2 -- ход начавшего игру
     3 -- ход не начавшего игру :)
    \*/
    static var status : Int = 0
    static var time = 0
    static var admin = false
    static var myGuess: Int = 5678
    static var myNumber : Int = 1234
    static var flag = false
    static func updateGame(url: URL) {
        let queryItems = URLComponents(string: url.absoluteString)?.queryItems
        let status : Int = Int((queryItems?.filter({$0.name == "status" as String}).first?.value)!)!
        let guess : Int = Int((queryItems?.filter({$0.name == "guess" as String}).first?.value)!)!
        let time : Int = Int((queryItems?.filter({$0.name == "time" as String}).first?.value)!)!
        print(status)
        print(guess)
        print(time)
        self.status = status
        self.time = time
        self.myGuess = guess
    }
    
    static func startGame() {
        status = 1
        admin = true
        time += 1
    }
    static func gameConfirm(step: Int) {
        self.myGuess = step
        flag = true
        status = 2
        admin = false
        time += 1
    }
    
    static func makeStep(step: Int) {
        flag = true
        self.myGuess = step
        status = status == 2 ? 3 : 2
        time += 1
    }
    
    static func calculateResult() -> (Int, Int) {
        return (2, 2)
    }
}

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
     1 -- предложение игры
     2 -- ход первого
     3 -- ход второго
     4 -- победа первого
     5 -- победа второго
    \*/
    static var status = 0
    static var firstNumber = 0
    static var secondNumber = 0
    static var firstRates = ""
    
    ам авт мтв амв м
    мвам вам
    static var secondRates = ""
    static var firstUUID = ""
    static var secondUUID = ""
    
    static func UpdateParams(url: URL) {
        let queryItems = URLComponents(string: url.absoluteString)?.queryItems
        self.status =       Int((queryItems?.filter({$0.name == "status" as String}).first?.value)!)!
        self.firstNumber =  Int((queryItems?.filter({$0.name == "fn" as String}).first?.value)!)!
        self.secondNumber = Int((queryItems?.filter({$0.name == "sn" as String}).first?.value)!)!
        self.firstRates = (queryItems?.filter({$0.name == "fr" as String}).first?.value)!
        self.secondRates = (queryItems?.filter({$0.name == "sr" as String}).first?.value)!
        self.firstUUID = (queryItems?.filter({$0.name == "fi" as String}).first?.value)!
        self.secondUUID = (queryItems?.filter({$0.name == "si" as String}).first?.value)!
    }
    
    static func ParseRates(str: String) -> [Int] {
        var t = 0
        var cur = 0
        for c in str.characters.filter({true} -> Bool ) {
            cur *= 10
            cur += Int()!
            if t == 4 {
                print(cur)
                cur = 0
                t = 0
            }
        }
        return [1];
    }
}

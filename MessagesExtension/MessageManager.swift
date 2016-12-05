//
//  MessageManager.swift
//  demoiM
//
//  Created by Иван Трофимов on 30.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation
import Messages

class MessageService {
    
    static func SendStepMessage (conversation: MSConversation) {
        let session = conversation.selectedMessage?.session ?? MSSession()
        let layout = MSMessageTemplateLayout()
        let result = Game.calculateResult()
        layout.caption = "У тебя \(result.0) быка и \(result.1) коровы \nЯ походил. \(Game.myGuess)?"
        let message = MSMessage(session: session)
        message.layout = layout
        message.url = URL(string: "http://bullsandcows.net?status=\(Game.status)&guess=\(Game.myGuess)&time=\(Game.time)")
        message.shouldExpire = false
        
        conversation.insert(message)
    }
    static func SendStartMessage (conversation: MSConversation) {
        let session = conversation.selectedMessage?.session ?? MSSession()
        let layout = MSMessageTemplateLayout()
        layout.caption = "Я походил хочу с тобой поиграть, нажми сюда :)"
        let message = MSMessage(session: session)
        message.layout = layout
        message.url = URL(string: "http://bullsandcows.net?status=\(Game.status)&guess=\(Game.myGuess)&time=\(Game.time)")
        message.shouldExpire = false
        conversation.insert(message)
    }
    static func SendResponceMessage (conversation: MSConversation) {
        let session = conversation.selectedMessage?.session ?? MSSession()
        let layout = MSMessageTemplateLayout()
        let result = Game.calculateResult()
        layout.caption = "У тебя \(result.0) быка и \(result.1) коровы"
        let message = MSMessage(session: session)
        message.layout = layout
        message.url = URL(string: "http://bullsandcows.net?status=\(Game.status)&guess=\(Game.myGuess)&time=\(Game.time)")
        message.shouldExpire = false
        conversation.insert(message)
    }
}

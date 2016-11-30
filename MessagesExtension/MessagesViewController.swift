//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Иван Трофимов on 28.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import UIKit
import Messages
import GoogleMobileAds



class Calculator {
    func Calculate() -> (Int, Int) {
        return (0, 0)
    }
}

class CompactViewController: UIViewController {
    var conversation : MSConversation?;
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var CompactLabel: UILabel!
    @IBAction func Button(_ sender: Any) {
        
    }
}

class ExpandedViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var butLabel: UIButton!
    @IBAction func buttonGo(_ sender: Any) {
        //textField.isHidden = true
    }
    
    var conversation : MSConversation?;
    @IBOutlet weak var ExtendedLabel: UILabel!
    override func viewDidLoad() {
        if Game.flag {
            MessageService.SendResponceMessage(conversation: conversation!)
            Game.flag = false
        }
        super.viewDidLoad()
        if (conversation?.selectedMessage) != nil {
            Game.updateGame(url: (conversation?.selectedMessage?.url)!)
        } else {
            ExtendedLabel.text = "Перейдите по сообщению или начните игру"
            butLabel.setTitle("Начните игру", for: UIControlState.normal)
        }
        if (Game.status == 1) {
            ExtendedLabel.text = "Сделайте ход для подтверждения"
            butLabel.setTitle("Волшебная кнопка!", for: UIControlState.normal)
        }
        if (Game.status == 2 || Game.status == 3) {
            ExtendedLabel.text = "Сделайте ход"
            butLabel.setTitle("Волшебная кнопка!", for: UIControlState.normal)
        }
        
    }
    @IBAction func But(_ sender: Any) {
        if Game.status == 0 {
            Game.startGame()
            MessageService.SendStartMessage(conversation: conversation!)
        } else
        if Game.status == 1 {
            Game.gameConfirm(step: Int(textField.text!)!)
            MessageService.SendStepMessage(conversation: conversation!)
        } else
        if Game.status == 2 {
            if Game.admin {
                Game.makeStep(step: Int(textField.text!)!)
            } else {
                ExtendedLabel.text = "Не твой ход"
            }
            MessageService.SendStepMessage(conversation: conversation!)
        }
        else
        if Game.status == 3 {
            if Game.admin {
                ExtendedLabel.text = "Не твой ход"
            } else {
                Game.makeStep(step: Int(textField.text!)!)
            }
            MessageService.SendStepMessage(conversation: conversation!)
        }
    }
    
}

class MessagesViewController: MSMessagesAppViewController {
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        presentVC(for: conversation, with: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else {
            fatalError("Expected the active conversation")
        }
        presentVC(for: conversation, with: presentationStyle)
    }
    
    private func presentVC(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        let controller: UIViewController
        
        if presentationStyle == .compact {
            controller = instantiateCompactVC()
            let d = controller as! CompactViewController
            d.conversation = conversation
        } else {
            controller = instantiateExpandedVC()
            let d = controller as! ExpandedViewController
            d.conversation = conversation
        }
        
        addChildViewController(controller)
        
        // ...constraints and view setup...
        
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    private func instantiateCompactVC() -> UIViewController {
        guard let compactVC = storyboard?.instantiateViewController(withIdentifier: "CompactVC") as? CompactViewController else {
            fatalError("Can't instantiate CompactViewController")
        }
        
        return compactVC
    }
    
    private func instantiateExpandedVC() -> UIViewController {
        guard let expandedVC = storyboard?.instantiateViewController(withIdentifier: "ExpandedVC") as? ExpandedViewController else {
            fatalError("Can't instantiate ExpandedViewController")
        }
        
        return expandedVC
    }
}

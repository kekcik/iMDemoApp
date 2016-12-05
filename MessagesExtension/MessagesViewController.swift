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

    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var constrain: NSLayoutConstraint!
    override func viewDidLoad() {
        Label.text = "Label \(self.view.frame.height) * \(self.view.frame.width)\n\(Label.frame.height) * \(Label.frame.width)\n\(Label.minimumScaleFactor)";
    }
    
    @IBAction func Button(_ sender: Any) {
    }
}

class ExpandedViewController: UIViewController {
    var conversation : MSConversation?;

    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GameManager.UpdateParams();
        //здесь надо обновить локальные переменные
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if conversation?.selectedMessage == nil {
            statusLabel.text = "новая игра";
        } else {
            statusLabel.text = "открылся из сообщения";
        }
    }
    @IBAction func mainButtonAction(_ sender: Any) {
        print("sending start")
        let session = conversation?.selectedMessage?.session ?? MSSession()
        let layout = MSMessageTemplateLayout()
        let result = Game.calculateResult()
        layout.caption = "У тебя \(result.0) быка и \(result.1) коровы \nЯ походил. \(Game.myGuess)?"
        let message = MSMessage(session: session)
        message.layout = layout
        message.url = URL(string: "http://bullsandcows.net?status=\(Game.status)&guess=\(Game.myGuess)&time=\(Game.time)")
        message.shouldExpire = false
        conversation?.insert(message)
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

//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Иван Трофимов on 28.11.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import UIKit
import Messages

class CompactViewController: UIViewController {
    var conversation : MSConversation?;
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var CompactLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print (conversation!.remoteParticipantIdentifiers)
        print (conversation!.localParticipantIdentifier)
        UUIDLabel.text = conversation!.localParticipantIdentifier.uuidString
        switch Constants.status(player: conversation!.localParticipantIdentifier.uuidString) {
        case 0:
            CompactLabel.text = "Начните игру"
            break
        case 1:
            CompactLabel.text = "Ваш ход"
            break
        case 2:
            CompactLabel.text = "Не Ваш ход"
            break
        default:
            break
        }
    }
    
    @IBAction func Button(_ sender: Any) {
        let session = conversation?.selectedMessage?.session ?? MSSession()
        let message = MSMessage(session: session)
        
        message.summaryText = "Sent Hello World message"
        message.accessibilityLabel = "accessibilityLabel"
        conversation?.insert(message)
        switch Constants.status(player: conversation!.localParticipantIdentifier.uuidString) {
        case 0:
            Constants.startGameFor(
                playerInit: conversation!.localParticipantIdentifier.uuidString,
                playersInit: conversation!.remoteParticipantIdentifiers
            )
            CompactLabel.text = "Сделайте ход"
            break
        case 1:
            if Constants.step(player: conversation!.localParticipantIdentifier.uuidString) {
                CompactLabel.text = "Вы сделали ход"
            } else {
                
            }
            break
        case 2:
            CompactLabel.text = "Не Ваш ход"
            break
        default:
            break
        }
    }
}

class ExpandedViewController: UIViewController {
    var conversation : MSConversation?;
    @IBOutlet weak var ExtendedLabel: UILabel!
    @IBAction func Button(_ sender: Any) {

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

//
//  GameViewController.swift
//  Bizingo
//
//  Created by Beatriz Plutarco on 31/01/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

extension GameViewController: ChatViewDelegate {
    func didTapSend(message: String) {
        guard let nickname = self.nickname else { return }
        SocketIOService.shared.sendMessage(message: message, withNickname: nickname)
    }
    
    func didTapGiveUP() {
        exitChat()
        updatePlayerConnection()
    }
}

class GameViewController: UIViewController {
    var nickname: String?
    var messages: [[String: AnyObject]]?
    var playersOn: [Player] = []
    
    var users: [[String: AnyObject]]? {
        didSet {
            updatePlayerConnection()
            addPlayerOn()
        }
    }
    
    lazy var chatView: ChatView = {
        let chatView = ChatView()
        chatView.translatesAutoresizingMaskIntoConstraints = false
        chatView.delegate = self
        view.addSubview(chatView)
        
        return chatView
    }()
    
    lazy var sceneView: GameSceneView = {
        let sceneView = GameSceneView()
        
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneView.gameScene = sceneNode
            }
        }
        
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sceneView)
        
        return sceneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContrstraints()
        updatePlayerConnection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if nickname == nil {
            getPlayerNickname()
        }
    }
    
    func addContrstraints() {
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneView.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            
            chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatView.topAnchor.constraint(equalTo: view.topAnchor),
            chatView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            chatView.widthAnchor.constraint(equalToConstant: view.frame.width/2)
        ])
    }

    func getPlayerNickname() {
        let alertController = UIAlertController(title: "SocketChat", message: "Please enter a nickname:", preferredStyle: UIAlertController.Style.alert)

        alertController.addTextField(configurationHandler: nil)

        let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
               let textfield = alertController.textFields![0]
               if textfield.text?.count == 0 {
                   self.getPlayerNickname()
               }
               else {
                   self.nickname = textfield.text
        
                SocketIOService.shared.connectToServerWithNickname(nickname: self.nickname!, completionHandler: { (userList) -> Void in
                        DispatchQueue.main.async {
                            if userList != nil {
                                self.users = userList
                            }
                        }
                   })
               }
           }

        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func exitChat() {
        SocketIOService.shared.exitChatWithNickname(nickname: nickname!) { () -> Void in
            DispatchQueue.main.async {
                self.nickname = nil
                self.users?.removeAll()
                self.getPlayerNickname()
            }
        }
    }
    
    func addPlayerOn() {
        var playerOne = Player(type: .one)
        var playerTwo = Player(type: .two)
        
        guard let usersCount = users?.count else { return }
        
        for num in 0...(usersCount) {
            //  Ver se tem um player conectado
            if num == usersCount-1 {
                let dictionary = users![num]
                playerOne.nickname = "\(String(describing: dictionary["nickname"]))"

                if "\(String(describing: dictionary["isConnected"]))" == "0" {
                    playerOne.isConnected = false
                } else {
                    playerOne.isConnected = true
                }
            }
            
            //  Ver se tem um segundo player conectado
            if num == usersCount-2 {
                let dictionary = users![num]
                playerTwo.nickname = "\(String(describing: dictionary["nickname"]))"

                if "\(String(describing: dictionary["isConnected"]))" == "0" {
                    playerTwo.isConnected = false
                } else {
                    playerTwo.isConnected = true
                }
            }
        }
        
        playersOn.append(playerOne)
        playersOn.append(playerTwo)
    }
    
    func updatePlayerConnection() {
//        self.chatView.textView.text = ""
        var playerName = ""
        var isConnected = ""
        
        self.users?.forEach({ (row) in
            if (row["nickname"] != nil) && (row["isConnected"] != nil) {
                playerName = "\(String(describing: row["nickname"]))"
                
                if "\(String(describing: row["isConnected"]))" == "0" {
                    isConnected = "disconnected"
                } else {
                    isConnected = "connected"
                }
            
//                self.chatView.textView.text = self.chatView.textView.text + "\n\(playerName) \(isConnected)"
            }
        })
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

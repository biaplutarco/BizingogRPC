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

extension GameViewController: StartViewDelegate {
    func change(to playerType: PlayerType) {
        self.playerType = playerType
    }
    
    func start() {
        getPlayerNickname()
    }
}

class GameViewController: UIViewController {
    var nickname: String!
    var playerType: PlayerType!
    
    var playersTyped: [Player] = []
    var players: [Player] = []
    
    lazy var startView: StartView = {
        let startView = StartView()
        startView.delegate = self
        startView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startView)
        
        return startView
    }()
    
    lazy var chatView: ChatView = {
        let chatView = ChatView()
        chatView.isHidden = true
        chatView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatView)
        
        return chatView
    }()
    
    lazy var sceneView: GameSceneView = {
        let sceneView = GameSceneView()
        sceneView.isHidden = true
        
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
    }
    
    private func updateUI() {
        chatView.isHidden = false
        sceneView.isHidden = false
        startView.isHidden = true
    }
    
    private func addContrstraints() {
        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startView.topAnchor.constraint(equalTo: view.topAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startView.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            
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
    
    private func update(with players: [Player]) {
        players.forEach { (player) -> Void in
            var playerTyped = player
            playerTyped.type = self.playerType
            
            self.playersTyped.append(playerTyped)
        }
        
        chatView.players = self.playersTyped
//        chatView.nickname = self.nickname
        
        self.playersTyped.forEach { (player) -> Void in
            if player.nickname == self.nickname {
                self.chatView.player = player
                self.sceneView.player = player
            }
        }
        
        updateUI()
    }

    func getPlayerNickname() {
        let alertController = UIAlertController(title: "SocketChat", message: "Please enter a nickname:", preferredStyle: UIAlertController.Style.alert)

        alertController.addTextField(configurationHandler: nil)

        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            let textfield = alertController.textFields![0]
            if textfield.text?.count == 0 {
                self.getPlayerNickname()
            } else {
                self.nickname = textfield.text
            
                SocketIOService.shared.connectToServer(with: self.nickname) { (players) in
                    DispatchQueue.main.async {
                        
                        if let players = players {
                            self.players = players
                            self.update(with: players)
                        }
                    }
                }
            }
        }
            
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
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
}

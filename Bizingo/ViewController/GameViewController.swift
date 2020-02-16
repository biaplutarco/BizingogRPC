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

class GameViewController: UIViewController {
    var nickname: String!
    var player: Player!
    var playerType: PlayerType!
    var playersTyped: [Player] = []
    var players: [Player] = []
    
    var loserNickname: String! {
        didSet {
            alertWinner()
        }
    }
    
    lazy var startView: StartView = {
        let startView = StartView()
        startView.delegate = self
        startView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startView)
        
        return startView
    }()
    
    lazy var chatView: ChatView = {
        let chatView = ChatView()
        chatView.delegate = self
        chatView.isHidden = true
        chatView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatView)
        
        return chatView
    }()
    
    lazy var sceneView: GameSceneView = {
        let sceneView = GameSceneView()
        sceneView.isHidden = true
        
        createGameScene(to: sceneView)
    
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sceneView)
        
        return sceneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContrstraints()
        getLoserNickname()
    }
    
    func updateStartView(to bool: Bool) {
        chatView.isHidden = bool
        sceneView.isHidden = bool
        
        if bool {
            restartGame()
        } else {
            startView.removeFromSuperview()
        }
    }
    
    //  Atualiza o player on
    private func update(with players: [Player], backToBeing bool: Bool) {
        players.forEach { (player) -> Void in
            var playerTyped = player
            playerTyped.type = self.playerType
            
            self.playersTyped.append(playerTyped)
        }
        
        chatView.players = self.playersTyped
        
        self.playersTyped.forEach { (player) -> Void in
            if player.nickname == self.nickname {
                self.player = player
                self.chatView.player = player
                self.sceneView.player = player
            }
        }
        
        updateStartView(to: bool)
    }
    
    //  Pegar o nome do player e criar um player
    func getPlayerNickname() {
        let alertController = UIAlertController(title: "Nickname", message: "Por favor, escreva o seu nickname:", preferredStyle: UIAlertController.Style.alert)

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
                            self.update(with: players, backToBeing: false)
                        }
                    }
                }
            }
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func createAlertWith(title: String, message: String, action: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    //  Cria o alerta para o player que desistiu
    func alertLoser() {
        let title = "Você PERDEU!"
        let message = "Às vezes, a melhor coisa a se fazer é desistir mesmo. Boa sorte na proxima!"
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.updateStartView(to: true)
            SocketIOService.shared.exitPlayer(with: self.player.nickname)
            self.player = nil
        }
        
        self.createAlertWith(title: title, message: message, action: action)
    }
    
    //  Pega o nome do player que desistiu
    func getLoserNickname() {
        SocketIOService.shared.getLoserNickname { (nickname) in
            if let nickname = nickname {
                self.loserNickname = nickname
            }
        }
    }
    
    //  Cria o alerta do player ganhador
    func alertWinner() {
        let title = "Você VENCEU!"
        let message = "O jogador \(loserNickname!) desistiu. Parabéns você cansou ele!"
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.updateStartView(to: true)
            SocketIOService.shared.exitPlayer(with: self.player.nickname)
            self.player = nil
        }
        
        self.createAlertWith(title: title, message: message, action: action)
    }
    
    private func restartGame() {
        startView = StartView()
        startView.delegate = self
        view.addSubview(startView)
        addStartViewConstraints()
    
        createGameScene(to: sceneView)
    }
    
    func createGameScene(to sceneView: GameSceneView) {
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneView.gameScene = sceneNode
            }
        }
    }
    
    private func addStartViewConstraints() {
        startView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startView.topAnchor.constraint(equalTo: view.topAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    
    private func addContrstraints() {
        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startView.topAnchor.constraint(equalTo: view.topAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
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

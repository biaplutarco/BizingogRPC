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
    var playersWithType: [Player] = []
    
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
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sceneView)
        createGameScene(to: sceneView)

        return sceneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContrstraints()
        getLoserNickname()
    }
    
    func goBackToStart(_ bool: Bool) {
        if bool == true {
            chatView.isHidden = bool
            sceneView.isHidden = bool
            restartGame()
        } else {
            startView.removeFromSuperview()
            chatView.isHidden = bool
            sceneView.isHidden = bool
        }
    }
    
    func createGameScene(to sceneView: GameSceneView) {
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneView.gameScene = sceneNode
            }
        }
    }
    
    func createAlertWith(title: String, message: String, action: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func addStartViewConstraints() {
        startView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startView.topAnchor.constraint(equalTo: view.topAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    
    func addContrstraints() {
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

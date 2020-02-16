//
//  GameSceneView.swift
//  Bizingo
//
//  Created by Bia on 12/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameSceneView: SKView {
    var player: Player! {
        didSet {
            GameScene.player = self.player
        }
    }
    
    var gameScene: GameScene? {
        didSet {
            gameScene?.scaleMode = .aspectFill
            self.presentScene(gameScene)
            self.ignoresSiblingOrder = true
        }
    }
}

//
//  GameScene.swift
//  Bizingo
//
//  Created by Beatriz Plutarco on 31/01/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import SpriteKit
import CoreGraphics
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var possibleMoves = [Any]()
    let movesManager = MovimentManager()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var board: Board!
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        buildBizingoBoard()
    }
    
    private func buildBizingoBoard() {
        self.board = Board()
        
        board.triangles.forEach { row in
            row.forEach { triangle in
                self.addChild(triangle)
            }
        }
        
        board.playerOnePieces.forEach { row in
            row.forEach({ piece in
                self.addChild(piece)
            })
        }
        
        board.playerTwoPieces.forEach { row in
            row.forEach({ piece in
                self.addChild(piece)
            })
        }
        
        resetTrianglesColor()
    }
    
    //  Resetar as cores
    private func resetTrianglesColor() {
        board.triangles.enumerated().forEach { i, line in
            line.enumerated().forEach { j, triangle in
                if i < 9 {
                    triangle.fillColor = (j % 2 == 0) ? .black : .white
                } else {
                    triangle.fillColor = (j % 2 == 0) ? .white : .black
                }
            }
        }
    }
    
    //  Pintar o triangulo clicado
    private func selectedTriangle(at point: CGPoint, resetOthers: Bool = true) {
        resetTrianglesColor()
        board.triangles.enumerated().forEach { i, line in
            line.enumerated().forEach { j, triangle in
                if triangle.contains(point) && triangle.isEmpty == false {
                    triangle.fillColor = .green
                    self.movesManager.showPossibleMoves(for: triangle.index, in: board)
//                    self.movesManager.showKilledTriangle(for: triangle, in: board)
                }
            }
        }
    }
        
    func touchDown(atPoint point: CGPoint) {
        selectedTriangle(at: point)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
        
        
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
            
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
            
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
            
        self.lastUpdateTime = currentTime
    }
}

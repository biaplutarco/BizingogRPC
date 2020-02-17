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
    static var player: Player!
    static var currentTriangle: Triangle!

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var possibleMoves = [Index]()
    var selectedPiece: Piece?

    var isSelecting: Bool = false
    
    private var lastUpdateTime : TimeInterval = 0
    
    var board: Board!
    private var moveManager: MovimentManager!
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        buildBizingoBoard()
    }
    
    private func buildBizingoBoard() {
        self.board = Board()
        self.moveManager = MovimentManager(board: board)
        
        board.triangles.forEach { row in
            row.forEach { triangle in
                self.addChild(triangle)
            }
        }
        
        board.playerOnePieces.forEach { piece in
            self.addChild(piece)
        }
        
        board.playerTwoPieces.forEach { piece in
            self.addChild(piece)
        }
        
        resetTrianglesColor()
    }
    
    //  Resetar as cores
    private func resetTrianglesColor() {
        board.triangles.enumerated().forEach { i, line in
            line.enumerated().forEach { j, triangle in
                if i < 9 {
                    triangle.fillColor = (j % 2 == 0) ? .darkTriangle : .triangle
                } else {
                    triangle.fillColor = (j % 2 == 0) ? .triangle : .darkTriangle
                }
            }
        }
    }
    
    //  Pintar o triangulo clicado
    private func selectedTriangle(at point: CGPoint, resetOthers: Bool = true) {
        resetTrianglesColor()
        
        var pieces = [Piece]()
        
        if GameScene.player.type == .one {
            board.playerOnePieces.forEach { onePieces in
                pieces.append(onePieces)
            }
        } else if GameScene.player.type == .two {
            board.playerTwoPieces.forEach { onePieces in
                pieces.append(onePieces)
            }
        }
        
        board.triangles.enumerated().forEach { i, line in
            line.enumerated().forEach { j, triangle in
                pieces.enumerated().forEach { j, piece in
                    if triangle.contains(point) &&
                        triangle.isEmpty == false &&
                        triangle.index == piece.currentIndex {
                        GameScene.currentTriangle = triangle
                        self.moveManager.showPossibleMoves(for: triangle.index)
                        self.selectedPiece = piece
                    }
                }
                
                if let piece = self.selectedPiece, triangle.contains(point) && triangle.isEmpty == true {
                    self.moveManager.move(piece: piece, to: triangle.index,
                                          in: triangle.getCenter(to: GameScene.player.type), playerType:  GameScene.player.type)
                    triangle.isEmpty = false
                    self.sendMove(from: piece.initialIndex, to: triangle.index)
                    
                    board.triangles.enumerated().forEach { i, line in
                        line.enumerated().forEach { j, triangle in
                            if triangle.index == piece.initialIndex {
                                triangle.isEmpty = true
                            }
                        }
                    }

                }
            }
        }
    }
    
    func sendMove(from: Index, to: Index) {
        let move = Move(from: from, to: to)
        SocketIOService.shared.send(movement: move)
    }
        
    func touchDown(atPoint point: CGPoint) {
        isSelecting = true
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

//
//  Piece.swift
//  Bizingo
//
//  Created by Bia on 07/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit



enum Type {
    case normal, captain
}

class Piece: SKShapeNode {
    var initialIndex: Index
    var origin: CGPoint {
        didSet {
            currentOrigin = origin
        }
    }
    
    var currentIndex: Index
    var scale: CGFloat
    var currentOrigin: CGPoint!
    
    var player: PlayerType
    var type: Type
    
    var isDead: Bool = false {
        didSet{
            update()
        }
    }
    
    init(origin: CGPoint, scale: CGFloat, initialIndex: Index, player: PlayerType, type: Type) {
        self.initialIndex = initialIndex
        self.currentIndex = initialIndex
        self.player = player
        self.type = type
        self.origin = origin
        self.scale = scale/14
        
        super.init()
        
        self.lineWidth = 0
        
        drawPiece(to: player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(to index: Index, in point: CGPoint) {
        var offset = CGPoint()
        let player: PlayerType = GameScene.player.type
        var center = CGPoint()
        
        switch player {
        case .one:
            offset = CGPoint(x: scale * 5, y: scale * 1)
            self.fillColor = .pieceOne
            center = CGPoint(x: origin.x - offset.x/4, y: origin.y + offset.y/2)

            if type == .captain {
                self.fillColor = .pieceOneCap
            }
        case .two:
            offset = CGPoint(x: scale * 5, y: scale * 10)
            self.fillColor = .pieceTwo
            center = CGPoint(x: origin.x - offset.x/4, y: origin.y + offset.y/4)

            if type == .captain {
                self.fillColor = .pieceTwoCap
            }
        case .none:
            print("")
        }
        
        let action = SKAction.move(by: distance(point, center), duration: 1)
        print(index)
        initialIndex = currentIndex
        currentIndex = index
        let move = Move(from: initialIndex, to: index)
        SocketIOService.shared.send(movement: move)
        print(index)
        self.run(action)
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGVector {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGVector(dx: xDist, dy: yDist)
    }
    
    private func update() {
        self.fillColor = .clear
    }
    
    func sendMove() {
        let move = Move(from: initialIndex, to: currentIndex)
        SocketIOService.shared.send(movement: move)
    }
    
    func updatePosition() {
        SocketIOService.shared.getGameMovement { (move) in
            if let move = move {
                self.initialIndex = move.from
                self.move(to: move.to, in: GameScene.currentTriangle.getCenter(to: GameScene.player.type))
            }
        }
    }
        
    private func drawPiece(to player: PlayerType) {
        var offset = CGPoint()
        
        switch player {
        case .one:
            offset = CGPoint(x: scale * 5, y: scale * 1)
            self.fillColor = .pieceOne

            if type == .captain {
                self.fillColor = .pieceOneCap
            }
        case .two:
            offset = CGPoint(x: scale * 5, y: scale * 10)
            self.fillColor = .pieceTwo
            
            if type == .captain {
                self.fillColor = .pieceTwoCap
            }
        case .none:
            print("")
        }
        
        let rect = CGRect(x: origin.x - offset.x, y: origin.y + offset.y, width: scale * 10, height: scale * 10)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: scale * 64)
        
        self.path = path.cgPath
    }
}

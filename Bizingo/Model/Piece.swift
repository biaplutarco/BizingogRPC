//
//  Piece.swift
//  Bizingo
//
//  Created by Bia on 07/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit

enum PlayerType {
    case one, two
}

enum Type {
    case normal, captain
}

class Piece: SKShapeNode {
    let initialIndex: Index
    let origin: CGPoint
    var currentIndex: Index
    var scale: CGFloat
    
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
    
    func move(to index: Index) {
        let action = SKAction.move(to: CGPoint(x: currentIndex.i - index.i, y: currentIndex.i - index.j), duration: 2)
        
        self.run(action)
    }
    
    private func update() {
        self.fillColor = .clear
    }
        
    private func drawPiece(to player: PlayerType) {
        var offset = CGPoint()
        
        switch player {
        case .one:
            offset = CGPoint(x: scale * 5, y: scale * 1)
            self.fillColor = .orange

            if type == .captain {
                self.fillColor = .red
            }
        case .two:
            offset = CGPoint(x: scale * 5, y: scale * 10)
            self.fillColor = .blue
            
            if type == .captain {
                self.fillColor = .purple
            }
        }
        
        let rect = CGRect(x: origin.x - offset.x, y: origin.y + offset.y, width: scale * 10, height: scale * 10)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: scale * 64)
        
        self.path = path.cgPath
    }
}

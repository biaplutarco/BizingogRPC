//
//  Piece.swift
//  Bizingo
//
//  Created by Bia on 07/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit

enum Player {
    case one, two
}

enum Type {
    case normal, captain
}

class Piece: SKShapeNode {
    let initialIndex: Index
    let origin: CGPoint

    var currentIndex: Index
    var player: Player
    var type: Type
    var isDead: Bool = false
    
    init(origin: CGPoint, initialIndex: Index, player: Player, type: Type) {
        self.initialIndex = initialIndex
        self.currentIndex = initialIndex
        self.player = player
        self.type = type
        self.origin = origin
        
        super.init()
        
        self.lineWidth = 0
        
        drawPiece(to: player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawPiece(to player: Player) {
        var offset = CGPoint()
        
        switch player {
        case .one:
            offset = CGPoint(x: 5, y: 1)
            self.fillColor = .orange

            if type == .captain {
                self.fillColor = .red
            }
        case .two:
            offset = CGPoint(x: 5, y: 10)
            self.fillColor = .blue
            
            if type == .captain {
                self.fillColor = .purple
            }
        }
        
        let rect = CGRect(x: origin.x - offset.x, y: origin.y + offset.y, width: 10, height: 10)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 64)
        
        self.path = path.cgPath
    }
}

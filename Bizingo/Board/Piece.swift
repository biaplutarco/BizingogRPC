//
//  Piece.swift
//  Bizingo
//
//  Created by Bia on 07/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit

struct Index {
    var i: Int
    var j: Int
}

enum Player {
    case one, two
}

enum Type {
    case normal, captain
}

class Piece: SKShapeNode {
    let initialIndex: Index
    let center: CGPoint

    var currentIndex: Index
    var player: Player
    var type: Type
    var isDead: Bool = false
    
    init(origin: CGPoint, initialIndex: Index, player: Player, type: Type) {
        self.initialIndex = initialIndex
        self.currentIndex = initialIndex
        self.player = player
        self.type = type
        self.center = CGPoint(x: origin.x - 5 , y: origin.y + 8)
        
        super.init()
        
        self.lineWidth = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawPiece(to player: Player) {
        let path = UIBezierPath(roundedRect: CGRect(x: center.x, y: center.y, width: 10, height: 10),
                                cornerRadius: 64)
        self.path = path.cgPath
        
        switch player {
        case .one:
            self.fillColor = .orange
        case .two:
            self.fillColor = .blue
        }
    }
}

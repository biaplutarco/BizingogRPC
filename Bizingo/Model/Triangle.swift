//
//  Triangle.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit

enum Direction {
    case normal, reverse
}

class Triangle: SKShapeNode {
    var scale: CGFloat
    var offset: CGPoint
    var boardOrigin: CGPoint
    var direction: Direction

    var index: Index
    var isEmpty: Bool = true
    
    init(boardOrigin: CGPoint, offset: CGPoint, index: Index, direction: Direction, scale: CGFloat) {
        self.boardOrigin = boardOrigin
        self.offset = offset
        self.index = index
        self.direction = direction
        self.scale = scale
        
        super.init()
        
        self.lineWidth = 0
        
        drawTriangle(to: direction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCenter(to player: PlayerType) -> CGPoint {
        switch player {
        case .one:
            let x = CGFloat(boardOrigin.x + offset.x)
            let y = CGFloat(boardOrigin.y + scale + offset.y)
            
            return CGPoint(x: x, y: y - (self.frame.width*sqrt(3))/2)
        case .two:
            let x = CGFloat(boardOrigin.x - scale + offset.x)
            let y = CGFloat(boardOrigin.y + scale + offset.y)
            
            return CGPoint(x: x + self.frame.width/2, y: y - (self.frame.width*sqrt(3))/2)
        }
    }
        
    private func drawTriangle(to direction: Direction) {
        let path = UIBezierPath()
        let boardX = boardOrigin.x
        let boardY = boardOrigin.y
        
        switch direction {
        case .normal:
            path.move(to: CGPoint(x: boardX + offset.x, y: boardY + scale + offset.y))
            path.addLine(to: CGPoint(x: boardX - scale + offset.x, y: boardY - scale + offset.y))
            path.addLine(to: CGPoint(x: boardX + scale + offset.x, y: boardY - scale + offset.y))
            path.addLine(to: CGPoint(x: boardX + offset.x, y: boardY + scale + offset.y))
            
            self.path = path.cgPath
        case .reverse:
            path.move(to: CGPoint(x: boardX - scale + offset.x, y: boardY + scale + offset.y))
            path.addLine(to: CGPoint(x: boardX + scale + offset.x, y: boardY + scale + offset.y))
            path.addLine(to: CGPoint(x: boardX + offset.x, y: boardY - scale + offset.y))
            path.addLine(to: CGPoint(x: boardX - scale + offset.x, y: boardY + scale + offset.y))
            
            self.path = path.cgPath
        }
    }
}

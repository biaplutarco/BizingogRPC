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
    var index: Index
    var direction: Direction
    var scale: CGFloat
    var center: CGPoint = CGPoint.zero
    var origin: CGPoint
    var boardOrigin: CGPoint {
        didSet {
            self.center = CGPoint(x: boardOrigin.x/2, y: (self.frame.width*sqrt(3))/4)
        }
    }
    
    init(boardOrigin: CGPoint, origin: CGPoint, index: Index, direction: Direction, scale: CGFloat) {
        self.boardOrigin = boardOrigin
        self.origin = origin
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
        
    private func drawTriangle(to direction: Direction) {
        let path = UIBezierPath()
        let boardX = boardOrigin.x
        let boardY = boardOrigin.y
        
        switch direction {
        case .normal:
            path.move(to: CGPoint(x: boardX + origin.x, y: boardY + scale + origin.y))
            path.addLine(to: CGPoint(x: boardX - scale + origin.x, y: boardY - scale + origin.y))
            path.addLine(to: CGPoint(x: boardX + scale + origin.x, y: boardY - scale + origin.y))
            path.addLine(to: CGPoint(x: boardX + origin.x, y: boardY + scale + origin.y))
            
            self.path = path.cgPath
        case .reverse:
            path.move(to: CGPoint(x: boardX - scale + origin.x, y: boardY + scale + origin.y))
            path.addLine(to: CGPoint(x: boardX + scale + origin.x, y: boardY + scale + origin.y))
            path.addLine(to: CGPoint(x: boardX + origin.x, y: boardY - scale + origin.y))
            path.addLine(to: CGPoint(x: boardX - scale + origin.x, y: boardY + scale + origin.y))
            
            self.path = path.cgPath
        }
    }
}

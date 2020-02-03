//
//  GameScene.swift
//  Bizingo
//
//  Created by Beatriz Plutarco on 31/01/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    override func sceneDidLoad() {
        drawBoard()
    }
    
    func drawBoard() {
        // Board parameters
        let numRows = 11
        let numCols = 11
        
        var collum = [3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 9]

        
        let xOffset: CGFloat = 100
        let yOffset: CGFloat = 50
        // Column characters
        let alphas: String = "abcdefghikl"
        // Used to alternate between white and black squares
        var toggle: Bool = false
        
        for row in 0...numRows - 1 {
            for col in 0...numCols - 1 {
                
                collum.forEach { (collumzinho) in
                    // Letter for this column
                    let colChar = Array(alphas)[col]
                    // Determine the color of square
                    let triangle = SKShapeNode()
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 30, y: 52))
                    path.addLine(to: CGPoint(x: 60, y: 0))
                    path.close()
                    triangle.path = path.cgPath
                    triangle.fillColor = .black
                    triangle.strokeColor = .clear
                    triangle.position = CGPoint(x: CGFloat(60 * collumzinho) - 330,
                                              y: CGFloat(52 * row))
                    // Set sprite's name (e.g., a8, c5, d1)
                    triangle.name = "\(colChar)\(2 - row)"
                    self.addChild(triangle)
                    toggle = !toggle
                }
                
                
                
            }
            toggle = !toggle
        }
    }
}

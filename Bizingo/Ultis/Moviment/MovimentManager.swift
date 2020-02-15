//
//  MovesManager.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit

struct MovimentManager {
    let walk = WalkMoviment()
    let kill = KillMoviment()
    let board: Board
    
    func move(piece: Piece, to index: Index) {
        piece.move(to: index)
    }
    
    //  Mostrar as possiveis casas que uma peça selecionada pode ir em um tabuleiro
    func showPossibleMoves(for index: Index) {
        board.triangles.enumerated().forEach { _, line in
            line.enumerated().forEach { _, triangle in
                checkMove(from: index, to: triangle)
            }
        }
    }
    
    func getPossibleMoves(for index: Index) -> [Index] {
        var moves = [Index]()
        
        board.triangles.enumerated().forEach { _, line in
            line.enumerated().forEach { _, triangle in
                if index.i < 8 && walk.getWalkFor(index: index, at: .others).contains(triangle.index) {
                    moves = walk.getWalkFor(index: index, at: .others)
                } else if index.i == 8 && walk.getWalkFor(index: index, at: .L8).contains(triangle.index) {
                    moves = walk.getWalkFor(index: index, at: .others)
                } else if index.i == 9 && walk.getWalkFor(index: index, at: .L9).contains(triangle.index) {
                    moves = walk.getWalkFor(index: index, at: .others)
                } else if index.i == 10 && walk.getWalkFor(index: index, at: .L10).contains(triangle.index) {
                    moves = walk.getWalkFor(index: index, at: .others)
                }
            }
        }
        
        return moves
        
    }
    
    private func checkMove(from index: Index, to triangle: Triangle) {
        if index.i < 8 && walk.getWalkFor(index: index, at: .others).contains(triangle.index) {
            paint(triangle)
        } else if index.i == 8 && walk.getWalkFor(index: index, at: .L8).contains(triangle.index) {
            paint(triangle)
        } else if index.i == 9 && walk.getWalkFor(index: index, at: .L9).contains(triangle.index) {
            paint(triangle)
        } else if index.i == 10 && walk.getWalkFor(index: index, at: .L10).contains(triangle.index) {
            paint(triangle)
        }
    }
    
    private func paint(_ triangle: Triangle) {
        if triangle.isEmpty == true {
            triangle.fillColor = .walkFree
        } 
    }
    
    //  Mostrar quando uma peça for morta
//    func showKilledTriangle(for selectedTriangle: Triangle, in board: Board) {
//        board.triangles.enumerated().forEach { (arg) in
//            let (_, line) = arg
//            line.enumerated().forEach({ (arg) in
//                let (_, triangle) = arg
//                if selectedTriangle.index.j % 2 == 0 {
//                    checkWhiteEnimies(to: triangle, i: selectedTriangle.index.i, j: selectedTriangle.index.j)
//                } else {
//                    checkBlackEnimies(to: triangle, i: selectedTriangle.index.i, j: selectedTriangle.index.j)
//                }
//                
//            })
//        }
//    }
    
//    func showPossibleKillers(for index: Index) {
//        board.triangles.enumerated().forEach { _, line in
//            line.enumerated().forEach { _, triangle in
//                checkKillers(from: index, to: triangle)
//            }
//        }
//    }
//
//    private func checkKillers(from index: Index, to triangle: Triangle) {
//        if index.i < 8 && walk.getWalkFor(index: index, at: .others).contains(triangle.index) {
//            paint(triangle)
//        } else if index.i == 8 && walk.getWalkFor(index: index, at: .L8).contains(triangle.index) {
//            paint(triangle)
//        } else if index.i == 9 && walk.getWalkFor(index: index, at: .L9).contains(triangle.index) {
//            paint(triangle)
//        } else if index.i == 10 && kill.getWalkFor(index: index, at: .L10).contains(triangle.index) {
//            paint(triangle)
//        }
//    }
      
    
    // Checa se uma peça esta rodeada de inimigos
//    private func checkEnimies(to triangle: Triangle, in kills: [Index]) {
//        kills.forEach { index in
//            if index == triangle.index {
//                triangle.fillColor = .red
//            }
//        }
//    }
    
}

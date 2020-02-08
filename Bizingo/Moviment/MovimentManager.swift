//
//  MovesManager.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit
import SpriteKit

//struct MovimentManager {
//    let walk = WalkMoviment()
//    let kill = KillMoviment()
//    
//    //  Mostrar as possiveis casas que uma peça selecionada pode ir em um tabuleiro
//    func showPossibleMoves(for selectedTriangle: Triangle, in board: BizingoBoard) {
//        board.triangles.enumerated().forEach { _, line in
//            line.enumerated().forEach({ _, triangle in
//                checkAllMoves(for: triangle, i: selectedTriangle.index.i, j: selectedTriangle.index.j)
//            })
//        }
//    }
//    
//    //  Checa todas as casas que tem um index andavel
//    private func checkAllMoves(for triangle: Triangle, i: Int, j: Int) {
//        if i < 8 {
//            checkMove(to: triangle, in: walk.getWalkFromDefault(selected: i, selected: j))
//        } else if i == 8 {
//            checkMove(to: triangle, in: walk.getWalkFromL8(selected: i, selected: j))
//        } else if i == 9 {
//            checkMove(to: triangle, in: walk.getWalkFromL9(selected: i, selected: j))
//        } else if i == 10 {
//            checkMove(to: triangle, in: walk.getWalkFromL10(selected: i, selected: j))
//        }
//    }
//    
//    //  Checa se uma casa tem um index andavel e pinta ele
//    private func checkMove(to triangle: Triangle, in walks: [(Int, Int)]) {
//        walks.forEach { index in
//            if index == triangle.index {
//                triangle.fillColor = .yellow
//            }
//        }
//    }
//    
//    //  Mostrar quando uma peça for morta
//    func showKilledTriangle(for selectedTriangle: Triangle, in board: BizingoBoard) {
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
//    
//    private func checkBlackEnimies(to triangle: Triangle, i: Int, j: Int) {
//        if i < 8 {
//            checkEnimies(to: triangle, in: kill.getKillDefaultMovesFor(i: i, j: j, isBlack: true))
//        } else if i == 8 {
//            checkEnimies(to: triangle, in: kill.getKillL8MovesFor(i: i, j: j, isBlack: true))
//        } else if i == 9 {
//            checkEnimies(to: triangle, in: kill.getKillL9MovesFor(i: i, j: j, isBlack: true))
//        } else if i == 10 {
//            checkEnimies(to: triangle, in: kill.getKillL10MovesFor(i: i, j: j, isBlack: true))
//        }
//    }
//    
//    private func checkWhiteEnimies(to triangle: Triangle, i: Int, j: Int) {
//        if i < 8 {
//            checkEnimies(to: triangle, in: kill.getKillDefaultMovesFor(i: i, j: j, isBlack: false))
//        } else if i == 8 {
//            checkEnimies(to: triangle, in: kill.getKillL8MovesFor(i: i, j: j, isBlack: false))
//        } else if i == 9 {
//            checkEnimies(to: triangle, in: kill.getKillL9MovesFor(i: i, j: j, isBlack: false))
//        } else if i == 10 {
//            checkEnimies(to: triangle, in: kill.getKillL10MovesFor(i: i, j: j, isBlack: false))
//        }
//    }
//    
//    // Checa se uma peça esta rodeada de inimigos
//    private func checkEnimies(to triangle: Triangle, in kills: [(Int, Int)]) {
//        kills.forEach { index in
//            if index == triangle.index {
//                triangle.fillColor = .red
//            }
//        }
//    }
//    
//}

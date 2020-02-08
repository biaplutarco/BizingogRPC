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
    
    //  Mostrar as possiveis casas que uma peça selecionada pode ir em um tabuleiro
    func showPossibleMoves(for index: Index, in board: Board) {
        board.triangles.enumerated().forEach { (arg) in
        
            let (_, line) = arg
            line.enumerated().forEach({ (arg) in
                
                let (_, triangle) = arg
                checkAllMoves(for: triangle, index: index)
            })
        }
    }
    
    //  Checa todas as casas que tem um index andavel
    private func checkAllMoves(for triangle: Triangle, index: Index) {
        if index.i < 8 {
            checkMove(to: triangle, in: walk.getWalkFor(index: index, at: .others))
        } else if index.i == 8 {
            checkMove(to: triangle, in: walk.getWalkFor(index: index, at: .L8))
        } else if index.i == 9 {
            checkMove(to: triangle, in: walk.getWalkFor(index: index, at: .L9))
        } else if index.i == 10 {
            checkMove(to: triangle, in: walk.getWalkFor(index: index, at: .L10))
        }
    }
    
    //  Checa se uma casa tem um index andavel e pinta ele
    private func checkMove(to triangle: Triangle, in walks: [Index]) {
        walks.forEach { index in
            if index == triangle.index {
                triangle.fillColor = .yellow
            }
        }
    }
    
    //  Mostrar quando uma peça for morta
    func showKilledTriangle(for selectedTriangle: Triangle, in board: Board) {
        board.triangles.enumerated().forEach { (arg) in
            let (_, line) = arg
            line.enumerated().forEach({ (arg) in
                let (_, triangle) = arg
                if selectedTriangle.index.j % 2 == 0 {
                    checkWhiteEnimies(to: triangle, i: selectedTriangle.index.i, j: selectedTriangle.index.j)
                } else {
                    checkBlackEnimies(to: triangle, i: selectedTriangle.index.i, j: selectedTriangle.index.j)
                }
                
            })
        }
    }
    
    private func checkBlackEnimies(to triangle: Triangle, i: Int, j: Int) {
        if i < 8 {
            checkEnimies(to: triangle, in: kill.getKillDefaultMovesFor(index: i, j, isBlack: true))
        } else if i == 8 {
            checkEnimies(to: triangle, in: kill.getKillL8MovesFor(i: i, j: j, isBlack: true))
        } else if i == 9 {
            checkEnimies(to: triangle, in: kill.getKillL9MovesFor(i: i, j: j, isBlack: true))
        } else if i == 10 {
            checkEnimies(to: triangle, in: kill.getKillL10MovesFor(i: i, j: j, isBlack: true))
        }
    }
    
    private func checkWhiteEnimies(to triangle: Triangle, i: Int, j: Int) {
        if i < 8 {
            checkEnimies(to: triangle, in: kill.getKillDefaultMovesFor(index: i, j, isBlack: false))
        } else if i == 8 {
            checkEnimies(to: triangle, in: kill.getKillL8MovesFor(i: i, j: j, isBlack: false))
        } else if i == 9 {
            checkEnimies(to: triangle, in: kill.getKillL9MovesFor(i: i, j: j, isBlack: false))
        } else if i == 10 {
            checkEnimies(to: triangle, in: kill.getKillL10MovesFor(i: i, j: j, isBlack: false))
        }
    }
    
    // Checa se uma peça esta rodeada de inimigos
    private func checkEnimies(to triangle: Triangle, in kills: [Index]) {
        kills.forEach { index in
            if index == triangle.index {
                triangle.fillColor = .red
            }
        }
    }
    
}

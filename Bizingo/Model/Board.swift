//
//  BizingoBoard.swift
//  Bizingo
//
//  Created by Beatriz Plutarco on 05/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import Foundation
import SpriteKit

class Board {
    var triangles: [[Triangle]] = []
    
//    var playerOne: Player
//    var playerTwo: Player
    
    var playerOnePieces: [Piece] = []
    var playerTwoPieces: [Piece] = []
    
    var origin: CGPoint
    var scale: CGFloat
    
    init() {
        self.scale = 30
        self.origin = CGPoint(x: 0, y: 300)
        
        for _ in 0...11 { triangles.append([]) }
//        for _ in 0...18{ playerOnePieces.append([]) }
//        for _ in 0...18{ playerTwoPieces.append([]) }
        
        drawBoard()
        addPieces()
    }
    
    //  Desenhar o tabuleiro
    func drawBoard() {
        drawLine(at: 0, numberOf: 5)
        drawLine(at: 1, numberOf: 7)
        drawLine(at: 2, numberOf: 9)
        drawLine(at: 3, numberOf: 11)
        drawLine(at: 4, numberOf: 13)
        drawLine(at: 5, numberOf: 15)
        drawLine(at: 6, numberOf: 17)
        drawLine(at: 7, numberOf: 19)
        drawLine(at: 8, numberOf: 21)
        drawReversedLine(at: 9, numberOf: 21, backoff: 8)
        drawReversedLine(at: 10, numberOf: 19, backoff: 7)
    }
    
    //  Desenhar as linhas crescentes
    private func drawLine(at i: Int, numberOf triangles: Int) {
        let xFactor: Int = (triangles - i - 3) * Int(-scale)
        
        for j in 0...triangles-1 {
            createTriangle(at: Index(i: i, j: j), with: xFactor, isReverdedLine: false)
        }
    }
    
    //  Desenhar as linhas decrescentes do tabuleiro
    private func drawReversedLine(at i: Int, numberOf triangles: Int, backoff: Int) {
        let xFactor = (triangles - backoff - 3) * Int(-scale)
        
        for j in 0...(triangles - 1) {
            createTriangle(at: Index(i: i, j: j), with: xFactor, isReverdedLine: true)
        }
    }
    
    //  Criar o triangulo
    private func createTriangle(at index: Index, with xFactor: Int, isReverdedLine: Bool) {
        let x = CGFloat(index.j * Int(scale) + xFactor)
        let y = CGFloat(index.i * Int(-scale) * 2)
        let offset = CGPoint(x: x, y: y)

        if isReverdedLine {
            if index.j % 2 == 0 {
                let triangle = Triangle(boardOrigin: origin, offset: offset, index: index,
                                        direction: .reverse, scale: scale)
                self.triangles[index.i].append(triangle)
            } else {
                let triangle = Triangle(boardOrigin: origin, offset: offset, index: index,
                                        direction: .normal, scale: scale)
                self.triangles[index.i].append(triangle)
            }
        } else {
            if index.j % 2 == 0 {
                let triangle = Triangle(boardOrigin: origin, offset: offset, index: index,
                                        direction: .normal, scale: scale)
                self.triangles[index.i].append(triangle)
            } else {
                let triangle = Triangle(boardOrigin: origin, offset: offset, index: index,
                                        direction: .reverse, scale: scale)
                self.triangles[index.i].append(triangle)
            }
        }
    }
    
    //  Adicionar peças ao tabuleiro
    private func addPieces() {
        triangles.forEach { row in
            row.forEach { triangle in
                if Index.playerOne.contains(triangle.index) {
                    triangle.isEmpty = false

//                    for num in 0...(playerOnePieces.count - 1) {
                    let piece = Piece(origin: triangle.getCenter(to: .one), scale: scale, initialIndex: triangle.index, player: .one, type: .normal)

                        self.playerOnePieces.append(piece)
//                    }
                } else if Index.playerOneCaptains.contains(triangle.index) {
                    triangle.isEmpty = false

//                    for num in 0...(playerOnePieces.count - 1) {
                        let piece = Piece(origin: triangle.getCenter(to: .one), scale: scale, initialIndex: triangle.index, player: .one, type: .captain)

                        self.playerOnePieces.append(piece)
//                    }
                } else if Index.playerTwo.contains(triangle.index) {
                    triangle.isEmpty = false
                    
//                    for num in 0...(playerTwoPieces.count - 1) {
                        let piece = Piece(origin: triangle.getCenter(to: .two), scale: scale, initialIndex: triangle.index, player: .two, type: .normal)

                        self.playerTwoPieces.append(piece)
//                    }
                } else if Index.playerTwoCaptains.contains(triangle.index) {
                    triangle.isEmpty = false

//                    for num in 0...(playerTwoPieces.count - 1) {
                        let piece = Piece(origin: triangle.getCenter(to: .two), scale: scale, initialIndex: triangle.index, player: .two, type: .captain)

                        self.playerTwoPieces.append(piece)
//                    }
                }
            }
        }
    }
}


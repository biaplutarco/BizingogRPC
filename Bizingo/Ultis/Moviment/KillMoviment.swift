//
//  KillMovesManeger.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

struct KillMoviment {
    func getKillers(for player: PlayerType, at index: Index, at line: SpecificLine) -> [Index] {
        let i = index.i
        let j = index.j
        
        var kills = [Index]()
        
        // Triangulos pretos
        if player == .one {
            switch line {
            case .others:
                kills = [Index(i: i, j: j - 1), Index(i: i - 1, j: j - 1), Index(i: i, j: j + 1)]
            case .L8:
                kills = [Index(i: i, j: j + 1), Index(i: i - 1, j: j - 1), Index(i: i, j: j - 1)]
            case .L9:
                kills = [Index(i: i, j: j + 1), Index(i: i - 1, j: j), Index(i: i, j: j - 1)]
            case .L10:
                kills = [Index(i: i, j: j + 1), Index(i: i - 1, j: j + 1), Index(i: i, j: j - 1)]
            }
        } else {
            switch line {
            case .others:
                kills = [Index(i: i + 1, j: j + 1), Index(i: i, j: j - 1), Index(i: i, j: j + 1)]
            case .L8:
                kills = [Index(i: i, j: j + 1), Index(i: i + 1, j: j), Index(i: i, j: j - 1)]
            case .L9:
                kills = [Index(i: i, j: j + 1), Index(i: i + 1, j: j - 1), Index(i: i, j: j - 1)]
            case .L10:
                kills = [Index(i: i, j: j + 1), Index(i: i + 1, j: j), Index(i: i, j: j - 1)]
            }
        }
        
        return kills
    }
    
//    func getKillDefaultMovesFor(index: Int, _ j: Int, isBlack: Bool) -> [Index] {
//        if isBlack == true {
//            return [Index(i: index, j: j - 1), Index(i: index - 1, j: j - 1), Index(i: index, j: j + 1)]
//        } else {
//            return [Index(i: index + 1, j: j + 1), Index(i: index, j: j - 1), Index(i: index, j: j + 1)]
//        }
//    }
//
//    func getKillL8MovesFor(i: Int, j: Int, isBlack: Bool) -> [Index] {
//        if isBlack {
//            return [Index(i: i, j: j + 1), Index(i: i - 1, j: j - 1), Index(i: i, j: j - 1)]
//        } else {
//            return [Index(i: i, j: j + 1), Index(i: i + 1, j: j), Index(i: i, j: j - 1)]
//        }
//    }
//
//    // linha reversa
//    func getKillL9MovesFor(i: Int, j: Int, isBlack: Bool) -> [Index] {
//        if isBlack == false {
//            return [Index(i: i, j: j + 1), Index(i: i - 1, j: j), Index(i: i, j: j - 1)]
//        } else {
//            return [Index(i: i, j: j + 1), Index(i: i + 1, j: j - 1), Index(i: i, j: j - 1)]
//        }
//    }
//
//    //  linha reversa
//    func getKillL10MovesFor(i: Int, j: Int, isBlack: Bool) -> [Index] {
//        if isBlack == false {
//            return [Index(i: i, j: j + 1), Index(i: i - 1, j: j + 1), Index(i: i, j: j - 1)]
//        } else {
//            return [Index(i: i, j: j + 1), Index(i: i + 1, j: j), Index(i: i, j: j - 1)]
//        }
//    }
}


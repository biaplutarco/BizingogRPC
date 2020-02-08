//
//  KillMovesManeger.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

struct KillMoviment {
    func getKillDefaultMovesFor(i: Int, j: Int, isBlack: Bool) -> [(Int, Int)] {
        if isBlack == true {
            return [(i, j - 1), (i - 1, j - 1), (i, j + 1)]
        } else {
            return [(i + 1, j + 1), (i, j - 1), (i, j + 1)]
        }
    }
    
    func getKillL8MovesFor(i: Int, j: Int, isBlack: Bool) -> [(Int, Int)] {
        if isBlack {
            return [(i, j + 1), (i - 1, j - 1), (i, j - 1)]
        } else {
            return [(i, j + 1), (i + 1, j), (i, j - 1)]
        }
    }
    
    // linha reversa
    func getKillL9MovesFor(i: Int, j: Int, isBlack: Bool) -> [(Int, Int)] {
        if isBlack == false {
            return [(i, j + 1), (i - 1, j), (i, j - 1)]
        } else {
            return [(i, j + 1), (i + 1, j - 1), (i, j - 1)]
        }
    }
    
    //  linha reversa
    func getKillL10MovesFor(i: Int, j: Int, isBlack: Bool) -> [(Int, Int)] {
        if isBlack == false {
            return [(i, j + 1), (i - 1, j + 1), (i, j - 1)]
        } else {
            return [(i, j + 1), (i + 1, j), (i, j - 1)]
        }
    }
}


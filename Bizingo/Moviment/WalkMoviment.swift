//
//  Moves.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

struct WalkMoviment {
    func getWalkFromDefault(selected i: Int, selected j: Int) -> [(Int, Int)] {
        return [(i - 1, j - 2), (i - 1, j),
                (i, j - 2), (i, j + 2),
                (i + 1, j + 2), (i + 1, j)]
    }
    
    func getWalkFromL8(selected i: Int, selected j: Int) -> [(Int, Int)] {
        return [(i - 1, j), (i - 1, j - 2),
                (i, j - 2), (i, j + 2),
                (i + 1, j + 1), (i + 1, j - 1)]
    }
    
    func getWalkFromL9(selected i: Int, selected j: Int) -> [(Int, Int)] {
        return [(i - 1, j + 1), (i - 1, j - 1),
                (i, j - 2), (i, j + 2),
                (i + 1, j - 2), (i + 1, j)]
    }
    
    func getWalkFromL10(selected i : Int, selected j: Int) -> [(Int, Int)] {
        return [(i - 1, j + 2), (i - 1, j),
                (i, j + 2), (i, j - 2)]
    }
}

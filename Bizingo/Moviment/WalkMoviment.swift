//
//  Moves.swift
//  Bizingo
//
//  Created by Bia on 06/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

enum SpecificLine {
    case others, L8, L9, L10
}

struct WalkMoviment {
    func getWalkFor(index: Index, at line: SpecificLine) -> [Index] {
        let i = index.i
        let j = index.j
        
        var moves = [Index]()
        
        switch line {
        case .others:
            moves = [Index(i: i - 1, j: j - 2), Index(i: i - 1, j: j),
                     Index(i: i, j: j - 2), Index(i: i, j: j + 2),
                     Index(i: i + 1, j: j + 2), Index(i: i + 1, j: j)]
        case .L8:
            moves = [Index(i: i - 1, j: j), Index(i: i - 1, j: j - 2),
                     Index(i: i, j: j - 2), Index(i: i, j: j + 2),
                     Index(i: i + 1, j: j + 1), Index(i: i + 1, j: j - 1)]
        case .L9:
            moves = [Index(i: i - 1, j: j + 1), Index(i: i - 1, j: j - 1),
                     Index(i: i, j: j - 2), Index(i: i, j: j + 2),
                     Index(i: i + 1, j: j - 2), Index(i: i + 1, j: j)]
        case .L10:
            moves = [Index(i: i - 1, j: j + 2), Index(i: i - 1, j: j),
                     Index(i: i, j: j + 2), Index(i: i, j: j - 2)]
        }
        
        return moves
    }
}

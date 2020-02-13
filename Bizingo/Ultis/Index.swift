//
//  Index.swift
//  Bizingo
//
//  Created by Bia on 08/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import Foundation

struct Index {
    var i: Int
    var j: Int
    
    static var playerOne: [Index] = [Index(i: 2, j: 2), Index(i: 2, j: 4), Index(i: 2, j: 6),
                                     Index(i: 3, j: 2), Index(i: 3, j: 4), Index(i: 3, j: 6),
                                     Index(i: 3, j: 8), Index(i: 4, j: 2), Index(i: 4, j: 4),
                                     Index(i: 4, j: 6), Index(i: 4, j: 8), Index(i: 4, j: 10),
                                     Index(i: 5, j: 2), Index(i: 5, j: 6), Index(i: 5, j: 8),
                                     Index(i: 5, j: 12)]
        
    static var playerTwo: [Index] = [Index(i: 7, j: 3), Index(i: 7, j: 7), Index(i: 7, j: 9),
                                     Index(i: 7, j: 11), Index(i: 7, j: 15), Index(i: 8, j: 5),
                                     Index(i: 8, j: 7), Index(i: 8, j: 9), Index(i: 8, j: 11),
                                     Index(i: 8, j: 13), Index(i: 8, j: 15), Index(i: 9, j: 6),
                                     Index(i: 9, j: 8), Index(i: 9, j: 10), Index(i: 9, j: 12),
                                     Index(i: 9, j: 14)]
    
    static var playerOneCaptains: [Index] = [Index(i: 5, j: 4), Index(i: 5, j: 10)]
    
    static var playerTwoCaptains: [Index] = [Index(i: 7, j: 5), Index(i: 7, j: 13)]
}

extension Index: Equatable {
    static func ==(lhs: Index, rhs: Index) -> Bool {
        return lhs.i == rhs.i && lhs.j == rhs.j
    }
}

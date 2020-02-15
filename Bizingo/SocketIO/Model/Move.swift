//
//  Move.swift
//  Bizingo
//
//  Created by Bia on 15/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import Foundation

struct Move: Codable {
    
    var from: Coordinate
    var to: Coordinate
    
    struct Coordinate: Codable {
        var row: Int
        var column: Int
    }
    
}


//
//  Player.swift
//  Bizingo
//
//  Created by Bia on 11/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import Foundation

struct Player {
    var type: PlayerType
    var nickname: String = ""
    var isConnected: Bool = false
//    var pieces: [Piece]
}

extension Player: Equatable {
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.type == rhs.type && lhs.nickname == rhs.nickname && lhs.isConnected == rhs.isConnected
    }
}

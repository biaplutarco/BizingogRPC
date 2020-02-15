//
//  Player.swift
//  Bizingo
//
//  Created by Bia on 11/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import Foundation

struct PlayersOn {
    var playerOne: Player
    var playerTwo: Player
}

enum PlayerType {
    case one, two, none
}

struct Player {
    var type: PlayerType = .none
    
    let identifier = UUID()
    let id: String
    let nickname: String
    let isConnected: Bool
    
    init(data: [String: AnyObject]) {
        self.id = data["id"] as! String
        self.nickname = data["nickname"] as! String
        self.isConnected = data["isConnected"] as! Bool
    }
}

extension Player: Equatable, Hashable {
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.type == rhs.type && lhs.nickname == rhs.nickname && lhs.isConnected == rhs.isConnected
    }
}

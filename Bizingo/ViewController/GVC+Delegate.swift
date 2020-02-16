//
//  GVC+ChatViewDelegate.swift
//  Bizingo
//
//  Created by Bia on 16/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

extension GameViewController: StartViewDelegate {
    func change(to playerType: PlayerType) {
        self.playerType = playerType
    }
    
    func start() {
        getPlayerNickname()
    }
}

extension GameViewController: ChatViewDelegate {
    func didTapRestart() {
        updateStartView(to: true)
        player = nil
    }
    
    func didTapGiveUp() {
        getLoserNickname()
        alertLoser()
    }
}

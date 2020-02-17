//
//  CVC+SocketIOService.swift
//  Bizingo
//
//  Created by Bia on 16/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

extension GameViewController {
    //  Pegar o nome do player
    func getPlayerNickname() {
        let alertController = UIAlertController(title: "Nickname",
                                                message: "Por favor, escreva o seu nickname:",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField(configurationHandler: nil)

        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            let textfield = alertController.textFields![0]
            if textfield.text?.count == 0 {
                self.getPlayerNickname()
            } else {
                self.connectPlayer(with: textfield.text!)
            }
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    //  Conectar o player
    func connectPlayer(with nickname: String) {
        SocketIOService.shared.connectToServer(with: nickname) { (players) in
            DispatchQueue.main.async {
                if let players = players {
                    self.nickname = nickname
                    self.update(with: players)
                }
            }
        }
    }
    
    //  Atualiza os players
    func update(with players: [Player]) {
        players.forEach { (player) -> Void in
            setType(to: player)
        }
        
        chatView.players = self.playersWithType
        
        self.playersWithType.forEach { (player) -> Void in
            if player.nickname == self.nickname {
                self.player = player
                self.chatView.player = player
                self.sceneView.player = player
            }
        }
        
        goBackToStart(false)
    }
    
    func updateMoves() {
        let board = self.sceneView.gameScene!.board!
        
        if player.type == .one {
            SocketIOService.shared.getGameMovement { (move) in
                if let move = move {
                    board.playerTwoPieces.forEach { (piece) in
                        if piece.initialIndex == move.from {
                            board.triangles.forEach { (row) in
                                row.forEach { (triangle) in
                                    if triangle.index == move.to {
                                        piece.move(to: move.to, in: triangle.getCenter(to: .two), playerType: .two)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        } else if player.type == .two {
            SocketIOService.shared.getGameMovement { (move) in
                if let move = move {
                    board.playerOnePieces.forEach { (piece) in
                        if piece.initialIndex == move.from {
                            board.triangles.forEach { (row) in
                                row.forEach { (triangle) in
                                    if triangle.index == move.to {
                                        piece.move(to: move.to, in: triangle.getCenter(to: .one), playerType: .one)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    //  Seta o type do player de acordo com o selecionado
    func setType(to player: Player) {
        var playerTyped = player
        playerTyped.type = self.playerType
        
        self.playersWithType.append(playerTyped)
    }
    
    //  Pega o nome do player que desistiu
    func getLoserNickname() {
        SocketIOService.shared.getLoserNickname { (nickname) in
            if let nickname = nickname {
                self.loserNickname = nickname
            }
        }
    }
    
    //  Restartar o jogo
    func restartGame() {
        SocketIOService.shared.exit(player: self.player.nickname, completion: {
            SocketIOService.shared.closeConnection()
        })
        
        startView = StartView()
        startView.delegate = self
        view.addSubview(startView)
        
        chatView.messages.removeAll()
        
        addStartViewConstraints()
        createGameScene(to: sceneView)
    }
    
    //  Cria o alerta do player ganhador
    func alertWinner() {
        let title = "Você VENCEU!"
        let message = "O jogador \(loserNickname!) desistiu. Parabéns você cansou ele!"
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.goBackToStart(true)
        }
        
        self.createAlertWith(title: title, message: message, action: action)
    }
    
    //  Cria o alerta para o player que desistiu
    func alertLoser() {
        let title = "Você PERDEU!"
        let message = "Às vezes, a melhor coisa a se fazer é desistir mesmo. Boa sorte na proxima!"
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.goBackToStart(true)
        }
        
        self.createAlertWith(title: title, message: message, action: action)
    }
}

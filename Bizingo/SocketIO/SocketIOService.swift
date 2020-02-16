//
//  SocketIOService.swift
//  Bizingo
//
//  Created by Bia on 11/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOService: NSObject {
    var playersOn: [Player]? {
        didSet {
            if let count = playersOn?.count, count > 2 {
                playersOn?.removeAll()
            }
        }
    }
    
    static let shared = SocketIOService()
    
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
     
    func closeConnection() {
        socket.disconnect()
    }
    
    //  Connect
    func connectToServer(with nickname: String, completion: @escaping ([Player]?) -> Void) {
        socket.emit("connectUser", nickname)
        socket.on("userList") { (data, _) in
            let players = (data[0] as? [[String: AnyObject]])?.map(Player.init)
            completion(players)
        }
    }
    
    //  Desconnect
    func exitPlayer(with nickname: String) {
        socket.emit("exitUser", nickname)
    }

    //  Chat
    func send(message: String, with nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    func getChatMessage(completion: @escaping (MessageInfo) -> Void) {
        socket.on("newChatMessage") { (data, _) -> Void in
            let message = MessageInfo(sender: data[0] as! String, content: data[1] as! String, date: data[2] as! String)
            completion(message)
        }
    }
    
    //  Moviments
    func send(movement: Move) {
        if let data = try? JSONEncoder().encode(movement) {
            socket.emit("gameMovement", data)
        }
    }
    
    func getGameMovement(completion: @escaping (Move?) -> Void) {
        socket.on("newGameMovement") { (data, _) -> Void in
            let movement = try? JSONDecoder().decode(Move.self, from: (data[0] as! Data))
            completion(movement)
        }
    }
    
    // Give Up
    func send(loser nickname: String) {
        socket.emit("giveUp", nickname)
    }
    
    func getLoserNickname(completion: @escaping (String?) -> Void) {
        socket.on("playerGiveUpName") { (data, _) in
            let nickname = data[0] as! String
            completion(nickname)
        }
    }
}

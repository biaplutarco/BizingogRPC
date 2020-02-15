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
//        socket.emit("connectUser", nickname)
//        //
//                socket.on("userList") { (dataArray, ack) in
//                    completionHandler(dataArray[0] as? [[String : AnyObject]])
//                }
        
        
        socket.emit("connectUser", nickname)
        socket.on("userList") { (data, _) in
            let players = (data[0] as? [[String: AnyObject]])?.map(Player.init)
            completion(players)
        }
    }
    
    func exitChat(with nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
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
    
    
//    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!,
//                                config: [.log(true), .compress])
//
//    lazy var socket: SocketIOClient = manager.defaultSocket
//
//    static let shared = SocketIOService()
//
//    private override init() {
//        super.init()
//    }
//
//    func establishConnection() {
//        socket.connect()
//    }
//
//    func closeConnection() {
//        socket.disconnect()
//    }
//
//    func connectToServerWithNickname(nickname: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
//        socket.emit("connectUser", nickname)
//
//        socket.on("userList") { (dataArray, ack) in
//            completionHandler(dataArray[0] as? [[String : AnyObject]])
//        }
//    }
//
//    func connectToServer(completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
//        guard let playersOnCount = playersOn?.count else { return }
//
//        if playersOnCount == 0 {
//            let playerOne = Player(type: .one)
//            playersOn?.append(playerOne)
//        } else if playersOnCount == 1 {
//            let playerTwo = Player(type: .two)
//            playersOn?.append(playerTwo)
//        }
//
//        if playersOn != nil {
//            socket.emit("connectUsers", with: playersOn!)
//        }
//    }
//
//    func exitChatWithNickname(nickname: String, completionHandler: @escaping () -> Void) {
//        socket.emit("exitUser", nickname)
//        completionHandler()
//    }
//
//    func sendMessage(message: String, withNickname nickname: String) {
//        socket.emit("chatMessage", nickname, message)
//    }
//
//    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
//        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
//            var messageDictionary = [String: AnyObject]()
//            messageDictionary["nickname"] = dataArray[0] as! String as AnyObject
//            messageDictionary["message"] = dataArray[1] as! String as AnyObject
//
//            completionHandler(messageDictionary)
//        }
//    }
}

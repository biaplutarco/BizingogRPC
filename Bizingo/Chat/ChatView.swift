//
//  ChatView.swift
//  Bizingo
//
//  Created by Bia on 12/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

class ChatView: UIView {
    var player: Player!
    var players: [Player] = []
    
    var messages: [MessageInfo] = []
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        return button
    }()
    
    lazy var giveUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Give Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapGiveUP(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        return button
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSend(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        return tableView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        return textField
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        addSubviewConstraints()
        getMessage()
    }
    
    @objc func didTapGiveUP(_ sender: UIButton) {
    }
    
    @objc func didTapSend(_ sender: UIButton) {
        if !textField.text!.isEmpty, let message = textField.text {
            SocketIOService.shared.send(message: message, with: player.nickname)
            textField.text = nil
            textField.resignFirstResponder()
        }
    }
    
    func getMessage() {
        SocketIOService.shared.getChatMessage { (message) in
            DispatchQueue.main.async {
                self.messages.append(message)
                self.tableView.reloadData()
            }
        }
    }
    
    func addSubviewConstraints() {
        NSLayoutConstraint.activate([
            restartButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            restartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            restartButton.widthAnchor.constraint(equalTo: sendButton.widthAnchor),
            restartButton.heightAnchor.constraint(equalToConstant: 40),
            
            giveUpButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            giveUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            giveUpButton.widthAnchor.constraint(equalTo: sendButton.widthAnchor),
            giveUpButton.heightAnchor.constraint(equalTo: restartButton.heightAnchor),

            tableView.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 400),
            
            textField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            sendButton.widthAnchor.constraint(equalTo: textField.widthAnchor, multiplier: 0.3)
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        
        let content = messages[indexPath.row].content
        let sender = messages[indexPath.row].sender
        
        let player = players.filter { (player) -> Bool in
            player.nickname == self.player.nickname
        }
        
        
        cell.setup(with: content, sender: sender, and: player.first!)
        
        return cell
    }
}

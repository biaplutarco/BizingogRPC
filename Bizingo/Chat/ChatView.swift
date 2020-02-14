//
//  ChatView.swift
//  Bizingo
//
//  Created by Bia on 12/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

struct ChatMessage {
    
}

protocol ChatViewDelegate: class {
    func didTapGiveUP()
    func didTapSend(message: String)
}

class ChatView: UIView {
    weak var delegate: ChatViewDelegate?
    
    var messages: [(nickname: String, message: String)] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
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
        self.backgroundColor = .gray
        addSubviewConstraints()
         getMessage()
    }
    
    @objc func didTapGiveUP(_ sender: UIButton) {
        delegate?.didTapGiveUP()
    }
    
    @objc func didTapSend(_ sender: UIButton) {
        delegate?.didTapSend(message: textField.text!)
        textField.text = ""
    }
    
    func getMessage() {
        SocketIOService.shared.getChatMessage { (messageInfo) -> Void in
            DispatchQueue.main.async {
                let nickname = messageInfo["nickname"] as! String
                let message = messageInfo["message"] as! String
                self.messages.append((nickname: nickname, message: message))
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
        print("EITA",messages)
        return messages.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        
        let message = messages[indexPath.row]
        cell.setup(with: message.nickname, message: message.message)
        
        return cell
    }
}

//
//  ChatTableViewCell.swift
//  Bizingo
//
//  Created by Bia on 13/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
   lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        return label
    }()
    
    lazy var colorView: UIView = {
           let view = UIView()
           view.backgroundColor = .lightGray
           view.layer.cornerRadius = 20
           view.translatesAutoresizingMaskIntoConstraints = false
           addSubview(view)
           
           return view
       }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    func setup(with nickname: String, message: String) {
        nicknameLabel.text = nickname
        messageLabel.text = message
        backgroundColor = .clear
        addSubviewConstraints()
        sendSubviewToBack(colorView)
    }
    
    private func addSubviewConstraints(){
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nicknameLabel.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 12),
            
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 3),
            messageLabel.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -12)
            
        ])
        
        if let name = nicknameLabel.text?.count,
            let message = messageLabel.text?.count,
            name > message {
            colorView.trailingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 16).isActive = true

        } else {
            colorView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true
        }
    }
}

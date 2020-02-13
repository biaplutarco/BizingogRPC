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
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        return label
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
        addSubviewConstraints()
    }
    
    private func addSubviewConstraints(){
        NSLayoutConstraint.activate([
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nicknameLabel.topAnchor.constraint(equalTo: topAnchor),
            
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

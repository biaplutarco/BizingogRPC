//
//  StartView.swift
//  Bizingo
//
//  Created by Bia on 15/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

protocol StartViewDelegate: class {
    func start()
    func change(to playerType: PlayerType)
}

class StartView: UIView {
    weak var delegate: StartViewDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Escolha um jogador:"
        label.textColor = .start
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("Começar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        return button
    }()
    
    lazy var playerSegmented: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.tintColor = .start
        segmented.insertSegment(withTitle: "Jogador 1", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Jogador 2", at: 1, animated: true)
        segmented.addTarget(self, action: #selector(change), for: .valueChanged)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmented)
        
        return segmented
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .darkTriangle
        addSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func start() {
        delegate?.start()
    }
    
    @objc func change() {
        switch playerSegmented.selectedSegmentIndex {
        case 1:
            updateUI(to: .playerTwo)
            delegate?.change(to: .two)
        default:
            updateUI(to: .playerOne)
            delegate?.change(to: .one)
        }
    }
    
    private func updateUI(to color: UIColor) {
        startButton.isHidden = false
        playerSegmented.tintColor = color
        startButton.backgroundColor = color
        titleLabel.textColor = color
    }
    
    func addSubviewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            playerSegmented.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            playerSegmented.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            playerSegmented.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerSegmented.widthAnchor.constraint(equalToConstant: 200),
            
            startButton.topAnchor.constraint(equalTo: playerSegmented.bottomAnchor, constant: 50),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

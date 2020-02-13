//
//  StartViewController.swift
//  Bizingo
//
//  Created by Bia on 13/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

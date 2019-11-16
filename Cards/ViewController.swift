//
//  ViewController.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cardView = CardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cardView.topAnchor.constraint(equalTo: view.topAnchor),
            cardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        // Do any additional setup after loading the view.
    }
}


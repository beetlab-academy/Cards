//
//  ViewController.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit
import CardView

class TinderCardView: Card {
    lazy var avatar: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iv)
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    var likeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSLayoutConstraint.activate([avatar.topAnchor.constraint(equalTo: topAnchor),
                                     avatar.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     avatar.leftAnchor.constraint(equalTo: leftAnchor),
                                     avatar.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {
    let mocker = MockDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cardView = CardView<TinderCardView>()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cardView.topAnchor.constraint(equalTo: view.topAnchor),
            cardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        cardView.prototype = { TinderCardView.self }
        cardView.onSetupCard = { (card, index) in
            card.avatar.image = UIImage(named: "fap")
        }
        cardView.displayData()
        
        mocker.loadTinder { data in
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print("result: \(jsonResult)")
            } catch {
                print("serialization erro = \(error)")
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
}


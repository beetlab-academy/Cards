//
//  CardView.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

class CardView: UIView {
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    private var startPoint: CGPoint = .zero
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstView.backgroundColor = .red
        addSubview(firstView)
        
        
        
        secondView.backgroundColor = .blue
        thirdView.backgroundColor = .black
        backgroundColor = .green

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGestureRecognizer)
        
    }
    
    override func layoutSubviews() {
        firstView.frame = CGRect(x: 50, y: 50, width: frame.width - 100, height: frame.height - 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView {
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .began:
            startPoint = gestureRecognizer.translation(in: self)
        case .changed:
            let diff = 50 + gestureRecognizer.translation(in: self).x//startPoint.x
            firstView.frame.origin.x = diff
            print(diff)
            break
        case .ended:
            startPoint = .zero
        @unknown default:
            break
        }
    }
}

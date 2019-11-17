//
//  CardView.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

open class Card: UIView {
    public func transionedToBack() {}
    public func appearAtFront() {}
}

class PanHandler: NSObject {
    var onStateChanged: ((UIPanGestureRecognizer) -> Void)?
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        onStateChanged?(gestureRecognizer)
    }
}

public final class CardView<T: Card>: UIView {
    private var firstView: T!
    private var secondView: T!
    private var thirdView: T!
    private var startPoint: CGPoint = .zero
    private var layoutOnceLock = false
    private let panHandler = PanHandler()
    private var queuePointer = 0
    
    
    public var onSetupCard: ((T,Int) -> Void)?
    public var prototype: (() -> T.Type)?
    public var cardsCount: (() -> Int)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpRecognizer()
    }
    
    override public func layoutSubviews() {
        if !layoutOnceLock {
            let cardPrototype = prototype!()
            firstView = cardPrototype.init()
            secondView = cardPrototype.init()
            thirdView = cardPrototype.init()
            
            firstView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            secondView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            thirdView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

            addSubview(thirdView)
            addSubview(secondView)
            addSubview(firstView)
            
            onSetupCard?(firstView, queuePointer)
            onSetupCard?(secondView, queuePointer + 1)
            onSetupCard?(thirdView, queuePointer + 2)


            layoutOnceLock = true
        }
    }
        
    public func displayData() {
    }
    
    public func reloadData() {
        queuePointer = 0
        displayData()
    }
    
    private func setUpRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: panHandler,
                                                          action: #selector(PanHandler.handlePan(_:)))
        addGestureRecognizer(panGestureRecognizer)
        panHandler.onStateChanged = { gestureRecognizer in
            switch gestureRecognizer.state {
            case .began:
                self.startPoint = gestureRecognizer.translation(in: self)
            case .changed:
                let diff = 50 + gestureRecognizer.translation(in: self).x//startPoint.x
                self.firstView.frame.origin.x = diff
                print(diff)
                break
            case .ended:
                self.startPoint = .zero
            default:
                break
            }
        }
    }
}

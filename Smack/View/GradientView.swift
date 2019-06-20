//
//  GradientView.swift
//  Smack
//
//  Created by juger on 6/20/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor : UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout() // after we change the value from the attripute inspecter to tell xcode there is some changes happened
        }
    }
    
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout() // after we change the value from the attripute inspecter to tell xcode there is some changes happened
        }
    }
    
    override func layoutSubviews() { // and if setNeedsLayout called this function will call also and here we will create our layer and add to that subClass
        let gradientLayer = CAGradientLayer() // it needs : Some colors , starting point , ending point and to know how big the layer is .
        gradientLayer.colors = [topColor.cgColor , bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }


}

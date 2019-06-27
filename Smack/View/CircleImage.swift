//
//  CircleImage.swift
//  Smack
//
//  Created by juger on 6/27/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}

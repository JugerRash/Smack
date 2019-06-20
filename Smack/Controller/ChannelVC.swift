//
//  ChannelVC.swift
//  Smack
//
//  Created by juger on 6/20/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60 
    }

}

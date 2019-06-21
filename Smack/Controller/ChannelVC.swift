//
//  ChannelVC.swift
//  Smack
//
//  Created by juger on 6/20/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //Outlets -:
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60 
    }

    //Actions -:
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: self)
    }
}

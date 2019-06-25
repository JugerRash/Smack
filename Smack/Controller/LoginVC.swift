//
//  LoginVC.swift
//  Smack
//
//  Created by juger on 6/21/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Actions -:
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
    }
    @IBAction func signupBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACOUNT, sender: nil)
    }
    
    

}

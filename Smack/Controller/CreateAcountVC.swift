//
//  CreateAcountVC.swift
//  Smack
//
//  Created by juger on 6/21/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class CreateAcountVC: UIViewController {

    // Outlets -:
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Action -:
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.userLogin(email: email, password: pass, completion: { (success) in
                    if success {
                        print("Logged in user!" , AuthService.instance.authToken)
                    }
                })
            } else {	
                print("failed to register user")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    
}

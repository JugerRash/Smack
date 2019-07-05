//
//  LoginVC.swift
//  Smack
//
//  Created by juger on 6/21/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // Outlets -:
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //Actions -:
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.userLogin(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        
        
    }
    @IBAction func signupBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACOUNT, sender: nil)
    }
    
    // Functions -:
    func setupView(){
        spinner.isHidden = true
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : SMACK_PURPLE_BACKGROUND])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : SMACK_PURPLE_BACKGROUND])
    }
    
    

}

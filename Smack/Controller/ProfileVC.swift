//
//  ProfileVC.swift
//  Smack
//
//  Created by juger on 7/4/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    
    // Outlets -:
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // Functions -:
    func setupView(){
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(compononts: UserDataService.instance.avatarColor)
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        

        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeProfileVC(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeProfileVC(_ recognizer : UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // Actions -:
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}

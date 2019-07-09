//
//  AddChannelVC.swift
//  Smack
//
//  Created by juger on 7/9/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // Outlets -:
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgColor: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // Actions -:
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else { return }
        guard let channelDescription = chanDesc.text else { return }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Functions -:
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.tapHold(_:)))
        bgColor.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : SMACK_PURPLE_BACKGROUND])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedString.Key.foregroundColor : SMACK_PURPLE_BACKGROUND])

    }
    
    @objc func tapHold(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    

}

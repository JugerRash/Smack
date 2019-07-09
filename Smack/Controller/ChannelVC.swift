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
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        
        SocketService.instance.getChannels { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUserDataInfo()
    }

    //Actions -:
    @IBAction func perpareForUnwind(segue : UIStoryboardSegue) { }
    
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
        
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        } else{
            performSegue(withIdentifier: TO_LOGIN, sender: self)
        }
        
        
    }
    
    // Functions -:
    @objc func userDataDidChange(_ notif : Notification){
        setUserDataInfo()
    }
    
    func setUserDataInfo(){
        if AuthService.instance.isLoggedIn {
            print("In Log in ")
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            print(UserDataService.instance.avatarColor)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(compononts: UserDataService.instance.avatarColor)
        }else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        
    }
    
    
}

extension ChannelVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.newWayChannels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            
            let channel = MessageService.instance.newWayChannels[indexPath.row]
            print(channel)
            cell.configureCell(channel: channel)
            return cell
            
        }else {
            return ChannelCell()
        }
    }
    
    
}

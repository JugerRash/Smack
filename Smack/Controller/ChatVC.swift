//
//  ChatVC.swift
//  Smack
//
//  Created by juger on 6/20/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var userTypingLbl: UILabel!
    
    //Variables :
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard() // to make the view going up with the keyboard
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80 // we need this lie to make the row height dynamicl
        tableView.rowHeight = UITableView.automaticDimension // and we need this also to make the height of row depends on the height of the label
        sendBtn.isHidden = true
        
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
//        SocketService.instance.getChatMessage { (success) in
//            if success {
//                self.tableView.reloadData()
//                if MessageService.instance.messages.count > 0 {// to make the tableView scroll to the last row
//                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
//                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
//                }
//            }
//        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            var names = ""
            var numOfTypers = 0
            
            for (typingUser , channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    }else {
                        names = "\(names) , \(typingUser)"
                    }
                    numOfTypers += 1
                }
            }
            if numOfTypers > 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numOfTypers > 1 {
                    verb = "are"
                }
                self.userTypingLbl.text = "\(names) \(verb) typing a message"
            }else {
                self.userTypingLbl.text = ""
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap(_:)))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIFI_CHANNEL_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        if messageTxtBox.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name , channelId)
        }else {
            if isTyping == false {
                sendBtn.isHidden = false
                 SocketService.instance.socket.emit("startType", UserDataService.instance.name , channelId)
            }
            isTyping = true
        }
    }
    
    
    @objc func userDataDidChange(_ notif : Notification){
        if AuthService.instance.isLoggedIn {
            // get channels
            onLoginGetMessage()
        }else {
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()	
        }
    }
    @objc func channelSelected(_ notif : Notification){
        updateWithChannel()
    }
    @objc func handleTap(_ recognizer : UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func sendMsgBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            guard let message = messageTxtBox.text , messageTxtBox.text != "" else { return }
            print(channelId , message)
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder() // to dismiss the keyboard
                     SocketService.instance.socket.emit("stopType", UserDataService.instance.name , channelId)
                }
            }
        }
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    
    func onLoginGetMessage(){
        MessageService.instance.findAllChannels { (success) in
            // Do some stuff
            if success{
                if MessageService.instance.newWayChannels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.newWayChannels[0]
                    self.updateWithChannel()
                }else {
                    self.channelNameLbl.text = "No Channels Yet"
                }
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    
}

extension ChatVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else {
            return MessageCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}

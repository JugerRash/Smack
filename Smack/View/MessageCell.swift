//
//  MessageCell.swift
//  Smack
//
//  Created by juger on 7/13/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets :
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Functions :
    func configureCell(message : Message){
        userImg.image = UIImage(named: message.userAvatar)
        userNameLbl.text = message.userName
        messageBodyLbl.text = message.message
        userImg.backgroundColor = UserDataService.instance.returnUIColor(compononts: message.userAvatarColor)
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
        
        
    }

}

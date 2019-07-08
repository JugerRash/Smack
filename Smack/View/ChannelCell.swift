//
//  ChannelCell.swift
//  Smack
//
//  Created by juger on 7/8/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // Outlets -:
    @IBOutlet weak var channelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
    }
    
    // Functions -:
    func configureCell(channel : newWayChannel){
        let title = channel.name!
        self.channelTitle.text = "#\(title)"
    }

}

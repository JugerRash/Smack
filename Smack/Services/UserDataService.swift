//
//  UserDataService.swift
//  Smack
//
//  Created by juger on 6/26/19.
//  Copyright © 2019 juger. All rights reserved.
//

import Foundation

class UserDataService {
    
    static var instance = UserDataService()
    
    // Variables -:
    public private(set) var name = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    public private(set) var email = ""
    public private(set) var id = ""
    
    func setUserData(name : String , email : String , id : String , avatarColor : String , avatarName : String){
        self.name = name
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
        self.id = id
    }
    
    func setAvatarName(avatarName : String ){
        self.avatarName = avatarName
    }
    
    
}

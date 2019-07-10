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
    
    
    // Functions -:
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
    
    func returnUIColor(compononts : String) -> UIColor {
        
        let scanner = Scanner(string: compononts)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r , g, b , a : NSString?
        
        scanner.scanUpToCharacters(from: comma , into: &r)
        scanner.scanUpToCharacters(from: comma , into: &g)
        scanner.scanUpToCharacters(from: comma , into: &b)
        scanner.scanUpToCharacters(from: comma , into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
    
    func logoutUser(){
        id = ""
        name = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        AuthService.instance.authToken = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannels()
    }
    
}

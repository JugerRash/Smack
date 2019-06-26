//
//  AuthService.swift
//  Smack
//
//  Created by juger on 6/25/19.
//  Copyright © 2019 juger. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//this class going to handle all stuff that related to log in , sign up and authontecation

class AuthService {
    
    static let instance = AuthService()
    
    //we will create some variables and store them into the phone using UserDefaults
    
    let defaults = UserDefaults.standard // it's just to store a small variables like bool , string and in ..... and it's not that secure so it's not recommanded to store password ....
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
        
    }
    
    
    func registerUser(email : String , password : String , completion : @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email" : lowerCaseEmail ,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
    
    func userLogin(email : String , password : String , completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email" : lowerCaseEmail ,
            "password" : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // OLD WAY
//                if let json = response.result.value as? Dictionary<String , Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//
//                }
                
                //Using SwiftyJSON
                guard let data = response.data else { return }
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name : String , email : String , avatarName : String , avatarColor : String  , completion : @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "name" : name,
            "email" : lowerCaseEmail ,
            "avatarName" : avatarName ,
            "avataColor" : avatarColor
        ]
        
        let header = [
            "Authorization" : "Bearer \(self.authToken)" ,
             "Content-Type" : "application/json; charset = utf-8"
        ]
        
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data)
                let id = json["id"].stringValue
                let name = json["name"].stringValue
                let avatarName = json["avatarName"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                let email = json["email"].stringValue
                
                UserDataService.instance.setUserData(name: name, email: email, id: id, avatarColor: avatarColor , avatarName: avatarName)
                
                completion(true)
                
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
        
    
    }
    
    
    
}

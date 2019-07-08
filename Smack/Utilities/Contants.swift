//
//  Contants.swift
//  Smack
//
//  Created by juger on 6/21/19.
//  Copyright © 2019 juger. All rights reserved.
//

import Foundation



typealias CompletionHandler = (_ Success : Bool) -> () 	//typealias it's to change the name of any type example : when you say : typealias jojo = String now we can make a variable from jojo and it will be a string

//(_ Success : Bool) -> ()     = it's a ver simple closure



//Segues
let TO_LOGIN = "toLogin"
let  TO_CREATE_ACOUNT = "toCreateAcount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//Notifications
let NOTIFI_USER_DATA_DID_CHANGE = Notification.Name("User data changed")

//Colors
let SMACK_PURPLE_BACKGROUND = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


// URL Constants
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BYEMAIL = "\(BASE_URL)user/byEmail/"
let URL_FIND_ALL_CHANNELS = "\(BASE_URL)channel"


// Headers
let HEADER = [
    "Content-Type" : "application/json; charset = utf-8"
]
let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)" ,
    "Content-Type" : "application/json; charset = utf-8"
]


// Cells
let AVATAR_CELL = "avatarCell"


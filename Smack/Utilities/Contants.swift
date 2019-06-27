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

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


// URL Constants
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"


// Headers
let HEADER = [
    "Content-Type" : "application/json; charset = utf-8"
]

// Cells
let AVATAR_CELL = "avatarCell"


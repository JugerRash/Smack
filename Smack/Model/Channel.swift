//
//  Channel.swift
//  Smack
//
//  Created by juger on 7/6/19.
//  Copyright © 2019 juger. All rights reserved.
//

import Foundation

// When you use the old way you will use this Struct
struct Channel {
    public private(set) var channelTitle : String!
    public private(set) var channelDescription : String!
    public private(set) var id : String!
}


//when you use the new way you have to use this struct
struct newWayChannel : Decodable {
    public private(set) var _id : String!
    public private(set) var name : String!
    public private(set) var description : String!
    public private(set) var __v : Int?	
}

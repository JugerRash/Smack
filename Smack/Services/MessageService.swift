//
//  MessageService.swift
//  Smack
//
//  Created by juger on 7/6/19.
//  Copyright © 2019 juger. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static var instance = MessageService()
    
    var channels = [Channel]()
    var newWayChannels = [newWayChannel]()
    var selectedChannel : newWayChannel?
    var messages = [Message]()
    var unreadMessages = [String]()
    
    func findAllChannels(completion : @escaping CompletionHandler) {
        
        Alamofire.request(URL_FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                //new way
                do {
                    self.newWayChannels = try JSONDecoder().decode([newWayChannel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                NotificationCenter.default.post(name: NOTIFI_CHANNEL_LOADED, object: nil)
                
                ///************************************************************************///
//                this is the old way
//                if let json = JSON(data).array {
//                    for item in json {
//                        let name = item["name"].stringValue
//                        let description = item["description"].stringValue
//                        let id = item["_id"].stringValue
//                        let channel = Channel(channelTitle: name, channelDescription: description, id: id)
//                        self.channels.append(channel)
//                    }
//
//
//                }
                  completion(true)
                
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    func findAllMessagesForChannel(channelId : String , completion : @escaping CompletionHandler){
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                if let json = JSON(data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let userName = item["userName"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let id = item["_id"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                }
                print("messages : \(self.messages)")
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func clearChannels(){
        newWayChannels.removeAll()
    }
    
    
}

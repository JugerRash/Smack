//
//  SocketService.swift
//  Smack
//
//  Created by juger on 7/9/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit
import SocketIO

// this class to make sure that our app is connected to the api and recive changes from api and it's veryimportant in chats app and we will use for adding channels and for messages :)

class SocketService: NSObject {
    
    static var instance = SocketService()//as every service making an instance
    // Variables -:
    var socketManager : SocketManager //
    var socket : SocketIOClient //
    
    // Constants -:
    override init() {
        self.socketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = socketManager.defaultSocket
        super.init()
    }
    
    // To make connection between the app and the server and it's good to call this functions in app delegate in the didBecameActive
    func establishConnection(){
        socket.connect()
    }
    
    // To close the connection between the app and the server and it's good to call this functions in app delegate in the willterminate
    func closeConnection(){
        socket.disconnect()
    }
    
    //To add A new channel to the api
    func addChannel(channelName : String , channelDescription : String , completion : @escaping CompletionHandler){
        socket.emit("newChannel", channelName , channelDescription)
        completion(true)
    }
    
    //To get channels from api and we should call this function in the calss that we want listen to this connection and in our app it is ChannelVC
    func getChannels(completion : @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = newWayChannel(_id: channelId, name: channelName, description: channelDescription, __v: nil)
            MessageService.instance.newWayChannels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody : String , userId : String , channelId : String , completion : @escaping CompletionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage", "Hi World" , userId , channelId , user.name , user.avatarName , user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion : @escaping (_ newMessage : Message) -> Void){
        socket.on("messageCreated") { (arrayData, ack) in
            guard let messageBody = arrayData[0] as? String else { return }
            guard let channelId = arrayData[2] as? String else { return }
            guard let userName = arrayData[3] as? String else { return }
            guard let userAvatar = arrayData[4] as? String else { return }
            guard let userAvatarColor = arrayData[5] as? String else { return }
            guard let id = arrayData[6] as? String else { return }
            guard let timeStamp = arrayData[7] as? String else { return }
            
            let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            completion(newMessage)
            
//            if channelId == MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
//                let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
//                MessageService.instance.messages.append(newMessage)
//                completion(true)
//            }else {
//                completion(false)
//            }
        }
    }
    
    func getTypingUsers(completionHandler : @escaping (_ typingUsers : [String : String]) -> Void){
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String : String] else { return }
            completionHandler(typingUsers)
        }
    }

}

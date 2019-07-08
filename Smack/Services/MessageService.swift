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

                print(self.newWayChannels)
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
    
}

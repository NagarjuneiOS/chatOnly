//
//  MessageModel.swift
//  ChatOnly
//
//  Created by THE BANYAN INFOTECH on 26/11/24.
//

import Foundation

struct userMessageModel: Equatable,Identifiable{
    var id: String { UUID().uuidString } 
    var message: String
    var receiver: String
    var sender: String
    var timeStamp: String
}

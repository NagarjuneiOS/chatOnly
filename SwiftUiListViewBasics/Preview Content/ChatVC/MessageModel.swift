//
//  MessageModel.swift
//  ChatOnly
//
//  Created by Nagarjune on 26/11/24.
//

import Foundation

struct userMessageModel: Equatable,Identifiable{
    var id = UUID()
    var message: String
    var receiver: String
    var sender: String
    var timeStamp: String
}

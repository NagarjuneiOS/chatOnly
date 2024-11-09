//
//  UserModel.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 09/11/24.
//

import Foundation

struct UsersModel{
    
    var firstName: String?
    var lastName: String?
    var number: String?
    var password: String?
    var timeStamp: String?
    init(firstName: String? = nil, lastName: String? = nil, number: String? = nil, password: String? = nil, timeStamp: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.password = password
        self.timeStamp = timeStamp
    }
}

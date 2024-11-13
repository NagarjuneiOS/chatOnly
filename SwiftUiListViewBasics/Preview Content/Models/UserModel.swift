//
//  UserModel.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 09/11/24.
//

import Foundation
import Firebase
import FirebaseDatabase

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

var ref: DatabaseReference = Database.database().reference()
var usersModel = [UsersModel]()
var getUserDetails: [UsersModel] = fetchUserDetails()
//Fetch user
func fetchUserDetails() -> [UsersModel]{
    var usersModel = [UsersModel]()
   ref.child("users").observe(.value, with: { snapshot in
       if let value = snapshot.value as? [String: Any] {
           // Process the updated value
           usersModel.removeAll()
           print("New value: \(value)")
           value.compactMap ({ $0.value }).compactMap { data in
               let datas = data as? [String: Any]
               let firstName = datas?["firstname"] as? String ?? ""
               let lastName = datas?["lastname"] as? String ?? ""
               let password = datas?["password"] as? String ?? ""
               let number = datas?["phonenumber"] as? String ?? ""
               let time = datas?["timestamp"] as? String ?? ""
               var tempUserModel = UsersModel(firstName: firstName,lastName: lastName,number: number,password: password,timeStamp: time)
               usersModel.append(tempUserModel)
           }
           dump(usersModel)
       }
   }) { error in
       print("Failed to read value: \(error.localizedDescription)")
   }
  
    return usersModel
}

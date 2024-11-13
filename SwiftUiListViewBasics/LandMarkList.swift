//
//  LandMarkList.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 22/10/24.
//

import SwiftUI


struct LandMarkList: View {
    @State var usersModel = [UsersModel]()
    @State private var showAlert = true

    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                HStack(){
                    Text("WhatsApp")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    HStack(spacing: 20) {
                        Image(systemName: "camera")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                        Image(systemName: "checkmark")
                            .padding()
                    }
                    
                }
                .padding(.top)
                Divider()
                List(usersModel, id: \.number){ landmarkss in
                    
                    NavigationLink(destination: ChatVC()) {
                       
                        LandmarkView(userData: landmarkss)
                    }
                    .navigationBarBackButtonHidden(true)

                }
                .listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -20))
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.fetchUserDetails()
        }

    }
    
    func sendRequestToUsers(){
        
            
    }
    
    func fetchUserDetails(){
      
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
      
       
    }
        
}

#Preview {
    LandMarkList()
}

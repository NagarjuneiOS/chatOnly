//
//  ChatVC.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 25/10/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging

var receiverUserNumberr = ""

struct ChatVC: View {
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode
    @State private var message: String = "" // State variable to hold the text input
    @State private var messages: [String] = [] // Array to hold messages
    let ref: DatabaseReference = Database.database().reference()
    @State private var messageDict = [[String: Any]()]
    @State private var arrOfUserMessageModel = [userMessageModel]()
    var sender = UserDefaults.standard.value(forKey: "login_number") as? String ?? ""
    @State private var childPath = ""
    
    
    var body: some View {
        HStack(){
            Image(uiImage: UIImage(named: "back")!)
                .resizable()           // Makes the image resizable
                .scaledToFit()         // Maintains the aspect ratio
                .frame(width: 30, height: 30)
            
            
                .onTapGesture {
                    print("image tapped")
                    presentationMode.wrappedValue.dismiss()
                }
            
             
            Text(receiverUserNumberr)
                    .font(.title)
                    .fontDesign(.rounded)
                    .padding()
            
            Spacer()
                .background(Color.purple)
            
            Text("Online")
                .fontWeight(.bold)
            Text("•")
                .background(Circle().fill(Color.green))
                .font(.system(size: 15, weight: .bold)) // Make the text larger and bold
                .foregroundColor(.white) // Set text color to white
                .padding(.horizontal, 10) // Horizontal padding for rounded effect
                .padding(.vertical, 5) // Vertical padding for height
                .background(Circle().fill(Color.green))
                .frame(width: 10,height: 10)
            
            
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .frame(height: 50)
        Spacer()
        ZStack {
            Image(uiImage: UIImage(named: "twinlake")!)
                .resizable()
              //  .ignoresSafeArea()

            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack {
                        ForEach(arrOfUserMessageModel) { model in
                            if model.sender == sender {
                                SenderMsgRow(msg: model.message)
                            } else {
                                ReceiverMsgVieew(msg: model.message)
                            }
                        }
                    }
                    .padding(.bottom,20)
                    .id(arrOfUserMessageModel.last?.id) // Attach ID to the last message
                }
                .listStyle(PlainListStyle())
                .onChange(of: arrOfUserMessageModel) { _ in
                    scrollToBottom(scrollView: scrollView)
                }
                .onAppear {
                    getMessages {
                        scrollToBottom(scrollView: scrollView)
                    }
                }
            }
        }
        HStack{
            TextField("Enter message", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
               // .padding()
                .frame(height: 60)
            ZStack {
                // Blue Circle
                Circle()
                    .fill(Color.green) // Fill the circle with blue color
                    .frame(width: 50, height: 50) // Set the size of the circle
                
                // Image inside the circle
                Image("msgsen") // Replace "yourImageName" with your actual image name
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle()) // Clip the image to a circle
                    .frame(width: 30, height: 30) // Set the size of the image
                    .padding(10) // Add padding to create a border effect
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        print("send button tapped")
                        self.messages.append(message)
                        self.sendMessage()
                        self.message = ""
                    }
            }
        }
        .frame(height: 20)
        .padding()
        
        .onAppear {
            print("receiver number ->\(receiverUserNumberr)")
         
        }
    }
    func prints(data: userMessageModel){
        print(data)
    }
    func getMessages(_ completion: @escaping () -> Void) {
        var sender = self.sender
        print(self.sender)
        print(receiverUserNumberr)
        
        ref.child("user_chats").observe(.value) { snapshot in
            if let userChats = snapshot.value as? [String: Any]{
                var keysArray = userChats.compactMap { $0.key }
                if keysArray.contains("\(sender)_\(receiverUserNumberr ?? "")"){
                    self.childPath = "\(sender ?? "")_\(receiverUserNumberr)"
                    
                } else if keysArray.contains("\(receiverUserNumberr)_\(sender)"){
                    print("True....\(keysArray)")
                    self.childPath = "\(receiverUserNumberr ?? "")_\(sender ?? "")"
                }else{
                    self.childPath = "\(sender ?? "")_\(receiverUserNumberr ?? "")"
                    print("")

                }
                self.getPath()
                    
                
            }

        
        }

    }
    // Helper method to scroll to the bottom
    private func scrollToBottom(scrollView: ScrollViewProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let lastMessageId = arrOfUserMessageModel.last?.id {
                print("Scrolling to last ID: \(lastMessageId)")
                withAnimation {
                    scrollView.scrollTo(lastMessageId, anchor: .bottom)
                }
            }
        }
    }
    func getPath(){
        print(childPath)
        ref.child("user_chats").child(childPath).observe(.value) { snapshot in
            // Debug: Print the raw snapshot value
            self.arrOfUserMessageModel.removeAll()
            self.messageDict.removeAll()
            print("Snapshot value: \(snapshot.value ?? "nil")")
            var messages = snapshot.value as? [Any]
            dump(messages)
      
            
            // Convert dictionary values to an array of dictionaries
            let messagesArray = messages?.compactMap { $0 as? [String: Any] }
            messagesArray?.enumerated().forEach({ index, data in
                dump(data)
                self.messageDict.append(data)
                let arrOfUserMessageModel = userMessageModel(message: data["message"] as? String ?? "", receiver: data["receiver"] as? String ?? "", sender: data["sender"] as? String ?? "", timeStamp: data["timestamp"] as? String ?? "")
               
                self.arrOfUserMessageModel.append(arrOfUserMessageModel)
                if (messagesArray?.count ?? 0) - 1 == index{
                }
            })

            // Print or use the messages
           
            print("Messages Array: \(arrOfUserMessageModel ?? [])")
            
        }
    }
    
        func sendMessage(){
            let sender = self.sender
            let receiver = receiverUserNumberr
            let userData = [
                "sender" : sender,
                "receiver": receiver,
                "message" : self.message,
                "timestamp": Date().description
            ] as [String : Any]
            
            self.messageDict.append(userData)
          //  var arrOfUserMessageModel = userMessageModel(message: userData["message"] as? String ?? "", receiver: userData["receiver"] as? String ?? "", sender: userData["sender"] as? String ?? "", timeStamp: userData["timestamp"] as? String ?? "")
           
          //  self.arrOfUserMessageModel.append(arrOfUserMessageModel)
            ref.child("user_chats").child(childPath).setValue(self.messageDict){ error, _ in
                if let error = error{
                    print(error)
                }else{
                    print("message saved successfully")
                }
                
            }
            
        
    }
 
}

#Preview {
    ChatVC()
}



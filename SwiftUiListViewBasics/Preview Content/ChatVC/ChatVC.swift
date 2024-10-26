//
//  ChatVC.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 25/10/24.
//

import SwiftUI

struct ChatVC: View {
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode
    @State private var message: String = "" // State variable to hold the text input
    @State private var messages: [String] = [] // Array to hold messages
    
    
    
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
            
            Text("Nagarjune")
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
            
            ScrollViewReader { scrollView in
                List {
                    ReceiverMsgVieew(msg: "A paraphrase or rephrase is the rendering of the same text in different words without losing the meaning.")
                        .listRowBackground(Color.clear)
                    
                    ForEach(messages.indices, id: \.self) { index in
                        SenderMsgRow(msg: messages[index])
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())
                .onChange(of: messages) { _ in
                    // Scroll to the bottom whenever the messages array updates
                    if let lastMessageIndex = messages.indices.last {
                        scrollView.scrollTo(lastMessageIndex, anchor: .bottom)
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
                        self.message = ""
                    }
            }
        }
        .frame(height: 40)
        .padding()
        
        
    }
}

#Preview {
    ChatVC()
}

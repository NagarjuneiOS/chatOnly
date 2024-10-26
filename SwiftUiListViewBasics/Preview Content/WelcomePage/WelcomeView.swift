//
//  WelcomeView.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 26/10/24.
//



import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        NavigationView{
            
            ZStack{
                Image(uiImage: UIImage(named: "chatting")!)
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Button(action:{
                        print("Register tapped")
                    }){
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .font(.title2) // Increases text size
                            .fontWeight(.semibold)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(10) // Rounds corners
                            .shadow(radius: 5) // Adds a slight shadow for depth
                    }
                    .padding(.horizontal,20)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Button(action: {
                        print("Login tapped") // Action for Login button
                    }) {
                        Text("Login")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity) // Expands button horizontally
                            .frame(height: 50) // Sets height to 50
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
        }
        
        
    }
}

#Preview {
    WelcomeView()
}

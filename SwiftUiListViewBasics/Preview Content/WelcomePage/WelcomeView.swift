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
                    // Login Button
              

                    NavigationLink(destination: RegisterView()) {
                                          Text("Register")
                                              .font(.title2)
                                              .fontWeight(.semibold)
                                              .frame(maxWidth: .infinity)
                                              .frame(height: 50)
                                              .background(Color.white)
                                              .foregroundColor(.black)
                                              .cornerRadius(10)
                                              .shadow(radius: 5)
                                      }
                                      .padding(.horizontal, 20)
                    NavigationLink(destination: LoginView()) {
                                          Text("Login")
                                              .font(.title2)
                                              .fontWeight(.semibold)
                                              .frame(maxWidth: .infinity)
                                              .frame(height: 50)
                                              .background(Color.pink)
                                              .foregroundColor(.white)
                                              .cornerRadius(10)
                                              .shadow(radius: 5)
                                      }
                                      .padding(.horizontal, 20)

                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    WelcomeView()
}

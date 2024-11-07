//
//  RegisterView.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 06/11/24.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode
    @State var firstName = ""
    @State var lastName = ""
    @State var number = ""
    @State var passWord = ""
    @State var confirmPassword = ""

    var body: some View {
        
        NavigationStack{
            
            
            HStack{
                HStack{
                    Image(uiImage: UIImage(named: "back")!)
                        .resizable()
                        .frame(width: 30,height: 30)
                        .padding()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                Text("Register")
                    .fontDesign(.default)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                
                    .foregroundColor(Color.pink)
                Spacer()
                
            }
            .padding(.top,-10)
            ScrollView{

            VStack{
                VStack(spacing: -20){
                    HStack{
                        Text("first name")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter First name",text: $firstName)
                        // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)
                        
                            .padding()
                    }
                    
                    
                }
                VStack(spacing: -20){
                    HStack{
                        Text("Last name")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter Last name",text: $lastName)
                        // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)
                        
                            .padding()
                    }
                    
                    
                }
                VStack(spacing: -20){
                    HStack{
                        Text("Phone number")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter Phone Number",text: $number)
                        // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)
                        
                            .padding()
                    }
                    
                    
                }
                VStack(spacing: -20){
                    HStack{
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter Password",text: $passWord)
                        // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)
                        
                            .padding()
                    }
                    
                    
                }
                VStack(spacing: -20){
                    HStack{
                        Text("Confirm Password")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter confirm Password",text: $confirmPassword)
                        // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)
                        
                            .padding()
                    }
                    
                    
                }
                
                
            }
            Spacer()
            
            Button {
                print("Register button tapped")
                
            } label: {
                Text("Register")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.pink)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                    .font(.title)
                
            }
            
            
            
        }

        }
        
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}

////
////  LoginView.swift
////  SwiftUiListViewBasics
////
////  Created by THE BANYAN INFOTECH on 26/10/24.
////
//
import SwiftUI

struct LoginView: View {
    @State private var userName = ""
    @State private var isCheckboxChecked = false

    var body: some View {
        
        NavigationStack{
            
            HStack{
                Text("Login")
                    .fontDesign(.default)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    
                    .foregroundColor(Color.pink)
                
            }
            VStack{
                VStack(spacing: -20){
                    HStack{
                        Text("User name:")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter username",text: $userName)
                           // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)

                            .padding()
                    }
                    
                    
                }
                VStack(spacing: -20){
                    HStack{
                        Text("Password:")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter Password",text: $userName)
                           // .padding(.horizontal, 10)
                            .frame(height: 50) // Increased height for username field
                            .background(Color(.systemGray6)) // Optional background color
                            .cornerRadius(8)

                            .padding()
                    }
                    
                    HStack{
                       // CheckboxView(isChecked: $isCheckboxChecked, label: "Remember me")
                       //     .padding() // Add padding around checkbox view
                        Text("Forgot password?")
                            .padding()

                    }
                    
                    
                }
                
                Button {
                    print("Login tapped")
                    
                } label: {
                    Text("login")
                      
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity) // Expands button horizontally
                        .frame(height: 50) // Sets height to 50
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()

                }


            }
            Spacer()
        }
        
        
        Spacer()
        
    }
    
    
}


#Preview {
    LoginView()
}


struct CheckboxView: View {
    @Binding var isChecked: Bool
    var label: String

    var body: some View {
        HStack {
            // Checkbox symbol
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20) // Set size of the checkbox
                .foregroundColor(isChecked ? .blue : .gray)
                .onTapGesture {
                    isChecked.toggle() // Toggle the checked state
                }

            // Label beside the checkbox
            Text(label)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5) // Vertical padding around checkbox and label
    }
}


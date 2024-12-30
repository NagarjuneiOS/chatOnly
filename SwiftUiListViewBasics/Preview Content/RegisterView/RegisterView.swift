//
//  RegisterView.swift
//  SwiftUiListViewBasics
//
//  Created by Nagarjune on 06/11/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseMessaging

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode
    @State var firstName = ""
    @State var lastName = ""
    @State var number = ""
    @State var passWord = ""
    @State var confirmPassword = ""
    @State var arrOfUserPhoneNumbers = [String]()
    @State var alertTitle = "Chat only"
    @State var alertMsg = "Entered phone number already registered"
    @State var isShowAlert = false
    @State var navigateToChat = false
    @State var navigationAlert = false
    var ref: DatabaseReference! = Database.database().reference() // Initialize Firebase Database reference

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
                        self.checkAuthentication { Bool in
                            if Bool{
                                self.registerUser()
                                self.isShowAlert = false
                                
                            }else{
                                self.isShowAlert = true
                            }
                        }
                        
                        
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
                    
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text(alertTitle),message: Text(alertMsg),dismissButton: .default(Text("OK")))
                    }
                    
                }
                .alert(isPresented: $navigationAlert) {
                    Alert(title: Text(alertTitle),message: Text(alertMsg),dismissButton: .default(Text("Ok"), action: {
                        UserDefaults.standard.set(self.number, forKey: "login_number")
                        UserDefaults.standard.set("true", forKey: "loggedin")
                        self.navigateToChat = true
                    }) )
                }
                
            }

            .navigationDestination(isPresented: $navigateToChat, destination: {
                LandMarkList()
            })
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                self.fetchUserDetails()
            }
        
    }
    
    func checkAuthentication(_ completion:(Bool) -> ()){
        if self.arrOfUserPhoneNumbers.contains(number){
            completion(false)

        }else{
            completion(true)
        }
        
        
    }
     func fetchUserDetails(){
         ref.child("users").observe(.value, with: { snapshot in
             if let value = snapshot.value as? [String: Any] {
                 // Process the updated value
                // print("New value: \(value)")
                 let datas: () = value.compactMap { $0.value }.forEach { data in
                     let datass = data as! [String: Any]
                    // print(datass["phonenumber"] as? String ?? "")
                     arrOfUserPhoneNumbers.append(datass["phonenumber"] as? String ?? "")
                 }
                 
             }
         }) { error in
             print("Failed to read value: \(error.localizedDescription)")
         }

        
        
    }
    func registerUser(){
        let userData = [
            "firstname" : firstName,
            "lastname": lastName,
            "phonenumber": number,
            "password" : passWord,
            "timestamp": Date().description
        ] as [String : Any]
        
        ref.child("users").child("\(firstName)_\(number)").setValue(userData){ error, _ in
            if let error = error{
                print(error)
            }else{
                print("User registered success")
                self.navigationAlert = true
                self.alertMsg = "Your registration seems successful"
            }
            
        }
        
    }
}

#Preview {
    RegisterView()
}

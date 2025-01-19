////
////  LoginView.swift
////  SwiftUiListViewBasics
////
////  Created by Nagarjune on 26/10/24.
////
//
import SwiftUI
import Firebase
import FirebaseDatabase

struct LoginView: View {
    
    //Mark variables:-
    @State var userModels = [UsersModel]()
    @State private var userName = ""
    @State private var passWord = ""
    @State private var isCheckboxChecked = false
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode
    let ref: DatabaseReference = Database.database().reference()
    @State var alertMessge = ""
    @State var showALert = false
    @State var loginSuccess = false
    var body: some View {
        
      
            NavigationStack{
                
                HStack{
                    HStack(){
                        Image(uiImage: UIImage(named: "back")!)
                            .resizable()           // Makes the image resizable
                            .scaledToFit()         // Maintains the aspect ratio
                            .frame(width: 30, height: 30)
                        
                        
                            .onTapGesture {
                                print("image tapped")
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding()
                        
                        
                        
                        
                    }
                    
                    Text("Login")
                        .fontDesign(.default)
                        .font(.system(size: 40))
                        .fontWeight(.black)
                    
                        .foregroundColor(Color.pink)
                    Spacer()
                    
                }
                VStack{
                    VStack(spacing: -20){
                        HStack{
                            Text("Phone number:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        HStack{
                            TextField("Enter Phone number",text: $userName)
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
                            TextField("Enter Password",text: $passWord)
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
                    
                    NavigationLink(destination: LandMarkList(),isActive: self.$loginSuccess) {
                        Button {
                            print("Login tapped")
                            self.checLogin()
                            
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
                        .alert(isPresented: $showALert) {
                            Alert(title: Text("Chat only"),message: Text(self.alertMessge),dismissButton: .default(Text("Ok"), action: {
                                self.loginSuccess = self.alertMessge == "login successful" ? true : false
                                    
                                
                               
                            }))
                        }
                    }
                    
                    
               
                
                    
                }
                Spacer()
            }
   
      
            .onAppear {
                self.fetchUserDetails()
            }
        
        Spacer()
            .navigationBarBackButtonHidden(true)
    }
    func checLogin(){
        var validation = "numbernotverified"
        self.userModels.enumerated().forEach { index ,value  in
        
            if userModels[index].number == userName{
                validation = "numberverified"
                if userModels[index].password == passWord{
                    validation = "success"
                }else{
                    validation = "passwordnotverified"
                }
                
                
            }
     
        }
        showALert = true
        if validation == "numbernotverified"{
            self.loginSuccess = false
            alertMessge = "Your number not verified please register yourself"
        }else if validation == "passwordnotverified"{
            self.loginSuccess = false
            alertMessge = "Your password is incorrect please enter correct password"

        }else{
            UserDefaults.standard.set(self.userName, forKey: "login_number")
            UserDefaults.standard.set("true", forKey: "loggedin")
            alertMessge = "login successful"
        }
        
    }
    
     func fetchUserDetails(){
        ref.child("users").observe(.value, with: { snapshot in
            if let value = snapshot.value as? [String: Any] {
                // Process the updated value
                self.userModels.removeAll()
                print("New value: \(value)")
                value.compactMap ({ $0.value }).compactMap { data in
                    let datas = data as? [String: Any]
                    let firstName = datas?["firstname"] as? String ?? ""
                    let lastName = datas?["lastname"] as? String ?? ""
                    let password = datas?["password"] as? String ?? ""
                    let number = datas?["phonenumber"] as? String ?? ""
                    let time = datas?["timestamp"] as? String ?? ""
                    UserDefaults.standard.set(datas?["imageurl"] as? String ?? "", forKey: "image")
                    var tempUserModel = UsersModel(firstName: firstName,lastName: lastName,number: number,password: password,timeStamp: time)
                    self.userModels.append(tempUserModel)
                }
                dump(self.userModels)
            }
        }) { error in
            print("Failed to read value: \(error.localizedDescription)")
        }
       
       
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


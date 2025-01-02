import SwiftUI
import Firebase
import FirebaseDatabase
struct NewWelcomeView: View {
    
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
        
        NavigationStack {
            ZStack{
                LinearGradient(colors: [Color.pink.opacity(0.2),Color.purple.opacity(0.5)], startPoint: .top, endPoint: .bottom)

                            .ignoresSafeArea()
            Spacer()
            VStack(spacing: 20) {
                // Logo or Image
                Image("chatting")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                    .cornerRadius(20)
                
                VStack(spacing: 0){
                    // Welcome Text
                    Text("Welcome back")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundStyle(.pink)
                    
                    // Subtext
                    Text("Login into your existing account")
                        .fontWeight(.light)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
                
                
                
                
                // Phone Number TextField
                VStack(spacing: 20) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 55)
                            .cornerRadius(10)
                            .shadow(radius: 2.0)// Corner radius applied to the rectangle
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.pink, lineWidth: 1)  // Border with color
                            )
                            .padding(.horizontal, 20)
                        
                        HStack {
                            Image("profile")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.leading, 30)
                            
                            TextField("Enter Phone number", text: $userName)
                                .padding(.leading, 10)
                                .frame(height: 50)
                                .cornerRadius(8)  // Optional: You can also give the TextField its own corner radius
                        }
                        
                    }
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 55)
                            .cornerRadius(10)
                            .shadow(radius: 2.0)// Corner radius applied to the rectangle
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.pink, lineWidth: 1)  // Border with color
                            )
                            .padding(.horizontal, 20)
                        
                        HStack {
                            Image("lock")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.leading, 30)
                            
                            TextField("Enter Password", text: $passWord)
                                .padding(.leading, 10)
                                .frame(height: 50)
                                .cornerRadius(8)  // Optional: You can also give the TextField its own corner radius
                        }
                        
                    }
                    HStack{
                        
                        Button(action: {
                            print("Forgot password tapped")
                        }) {
                            Text("Forgot password?")
                                .font(.caption)
                                .foregroundColor(.teal)
                                .frame(width: 200, height: 20)
                            // .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                }
                VStack(spacing: 0){
                    // Login Button
                    
                    NavigationLink(destination: LandMarkList(),isActive: $loginSuccess) {
                        Button(action: {
                            // Handle login action
                            print("Login button tapped")
                            self.checLogin()
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(Color.pink)
                                .cornerRadius(10)
                                .padding(.top, 20)
                        }
                        .alert(isPresented: $showALert) {
                            Alert(title: Text("Chat only"), message: Text(self.alertMessge),dismissButton: .default(Text("Ok"), action: {
                                self.loginSuccess = self.alertMessge == "login successful" ? true : false
                            }))
                        }
                    }
                    
                    
                    Text("Or")
                        .font(.headline)
                        .padding()
                    
                    NavigationLink(destination: RegisterView()) {
                        
                        
                        Text("Sign Up")
                        
                            .font(.headline)
                            .foregroundColor(.pink)
                            .frame(width: 300, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.pink, lineWidth: 1)  // Border with color
                            )
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                Spacer()
            }
            .padding(.top, 20)
        }
            
        }
        .onAppear {
            self.userName = ""
            self.passWord = ""
            self.fetchUserDetails()
        }
        .navigationBarBackButtonHidden(true)
    }
    func checLogin(){
        var validation = "numbernotverified"
        if self.userName == ""{
            validation = "entervalidcredenicials"
        }else if self.passWord == ""{
            validation = "entervalidcredenicials"

        }
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

        }else if validation == "entervalidcredenicials"{
            self.loginSuccess = false
            alertMessge = "Please enter the valid credencials"
        }
            else{
                print(self.userName)
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
    NewWelcomeView()
}

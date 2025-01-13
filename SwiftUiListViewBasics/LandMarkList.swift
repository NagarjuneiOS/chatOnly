import SwiftUI

struct LandMarkList: View {
    @State var usersModel = [UsersModel]()
    @State var requestListModel = [RequestListModel]()
    @State private var showAlert = false
    @State private var navigateToChat = false
    @State private var alertMessage = ""
    @State private var userNumber = ""
    @State private var showAlertForAcceptRequest = false
    @State private var requestUpdateKey = ""
    @State private var receiverUserNumber = ""
    @State private var navigateToSettings = false
    @State private var username: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var profilePicture: String = ""
    @State private var navigateToProfile = false
    @State private var nochatsFound = true

    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.pink.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    VStack(spacing: -20) {
                        Text("Chat Only")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.pink)
                        
                        HStack() {
                            VStack(spacing: 0) {
                                Text("Hi \(username), Welcome back")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.black)
                                    .padding()
                            }
                            Spacer()
                            
                            HStack(spacing: 20) {
                                Menu {
                                    
                                    
                                    Button {
                                        print("Profile button tapped")
                                        self.navigateToProfile = true
                                    } label: {
                                        Text("Profile")
                                        Image("profile")
                                    }
                                    Button {
                                        print("Logout button tapped")
                                        self.reset() // Call reset when the settings button is tapped
                                        self.navigateToSettings = true
                                    } label: {
                                        Text("Logout")
                                        Image("switch")
                                    }
                                    
                                } label: {
                                    Image(uiImage: UIImage(named: "settings")!)
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.pink)
                                        .padding()
                                }
                            }
                        }
                        .padding(.top)
                    }
                    Divider()
                    if nochatsFound{
                        VStack {
                            Spacer()
                            Text("No users found")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }else{
                    List(usersModel, id: \.number) { userModel in
                        Button {
                            self.receiverUserNumber = userModel.number ?? ""
                            receiverUserNumberr = userModel.number ?? ""
                            sendRequestToUsers(userModel: userModel) {}
                        } label: {
                            LandmarkView(userData: userModel)
                            
                        }
                        .buttonStyle(PlainButtonStyle()) // Prevents automatic button styling changes
                        .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10)) // Remove padding between list rows
                    }
                    .listStyle(PlainListStyle())
                    .padding(EdgeInsets(top: 10, leading: -20, bottom: 0, trailing: -20))
                    
                  
                }
                   
                }
                NavigationLink(destination: ChatVC(), isActive: $navigateToChat) {}
                    .hidden()
                    .navigationDestination(isPresented: $navigateToSettings) {
                        NewWelcomeView()
                    }
                    .navigationDestination(isPresented: $navigateToProfile, destination: {
                        ProfileView(firstName: $username, lastName: $lastName, password: $password, phoneNumber: $phoneNumber, profilePicUlr: $profilePicture, referredProfilePicUlr: profilePicture, referencedFirstName: username)
                    })
                    .hidden()
            }
            .onAppear {
                self.userNumber = UserDefaults.standard.value(forKey: "login_number") as? String ?? ""
                self.fetchUserDetails()
                self.requestListModels()
            }

        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: Binding<Bool>(
            get: { showAlert || showAlertForAcceptRequest },
            set: { _ in }
        )) {
            if showAlertForAcceptRequest {
                return Alert(
                    title: Text("Chat Only"),
                    message: Text("User sent request to you, you may accept or reject the request"),
                    primaryButton: .default(Text("Decline"), action: {
                        self.handleRequestResponse(accept: false)
                    }),
                    secondaryButton: .default(Text("Accept"), action: {
                        self.handleRequestResponse(accept: true)
                    })
                )
            } else {
                return Alert(
                    title: Text("Chat Only"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("Ok"), action: {
                        self.showAlert = false
                    })
                )
            }
        }
        .onAppear {
            self.userNumber = UserDefaults.standard.value(forKey: "login_number") as? String ?? ""
            self.fetchUserDetails()
            self.requestListModels()
        }
        
    }
    
    func reset() {
        UserDefaults.standard.set("", forKey: "login_number")
        UserDefaults.standard.set("false", forKey: "loggedin")
    }
    
    func sendRequestToUsers(userModel: UsersModel ,completion: () -> ()){
        print((userModel.number ?? "") as String)
        if self.requestListModel.count > 0{
            var key = ""
            var value = ""
            var getKey = self.requestListModel.compactMap { $0.key}
            if getKey.contains("\(self.userNumber)-\(userModel.number ?? "")") {
                key = "\(self.userNumber)-\(userModel.number ?? "")"
            }else if getKey.contains("\(userModel.number ?? "")-\(self.userNumber)"){
               key = "\(userModel.number ?? "")-\(self.userNumber)"
            }
            
            self.requestListModel.forEach { RequestListModel in
                if RequestListModel.key == key{
                    value = RequestListModel.value ?? ""
                }
            }
            
            
                
                switch value{
                case "request_sent":
                    
                    if (key == "\(self.userNumber)-\(userModel.number ?? "")"){
                        self.showAlert = true
                        self.alertMessage = "Request already sent please wait for your friend accept your request"
                    }else{
                        self.requestUpdateKey = key
                        self.showAlertForAcceptRequest = true
                        
                    }
                    
                    break
                case "request_accepted":
                    self.showAlert = false
                    self.navigateToChat = true
                    break
                case "request_declined":
                    self.showAlert = true
                    self.navigateToChat = false
                    break
                default:
                    ref.child("request_list").child("\("\(self.userNumber)-\(userModel.number ?? "")")").setValue("request_sent"){ error ,_ in
                            if let error = error{
                                print("error")
                            }else{
                                print("Request sent successfully")
                                self.showAlert = true
                                self.alertMessage = "Request sent successfully"

                            }

                        }
                    break
                }
 
            
            
        }else{
            ref.child("request_list").child("\("\(self.userNumber ?? "")-\(userModel.number ?? "")")").setValue("request_sent"){ error ,_ in
                if let error = error{
                    print("error")
                }else{
                    print("Request sent successfully")
                    self.showAlert = true
                    self.alertMessage = "Request sent successfully"
                }
                
            }
        }
        
        
        
        
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
                    let image = datas?["imageurl"] as? String ?? ""
                    if self.userNumber != number{
                        let tempUserModel = UsersModel(firstName: firstName,lastName: lastName,number: number,password: password,timeStamp: time,imageurl: image)
                        usersModel.append(tempUserModel)
                    }else{
                        self.username = firstName
                        self.lastName = lastName
                        self.password = password
                        self.phoneNumber = number
                        self.profilePicture = image
                    }
                    
                }
                dump(usersModel)
                self.nochatsFound = self.usersModel.count == 0 ? true : false
            }
        }) { error in
            print("Failed to read value: \(error.localizedDescription)")
        }
        
        
    }
    func requestListModels(){
        
        
        ref.child("request_list").observe(.value, with: { snapshot in
            if let value = snapshot.value as? [String: Any] {
                // Process the updated value
                requestListModel.removeAll()
                print("New value: \(value)")
                
                value.forEach { values in
                    var requeslistt = RequestListModel(key: values.key ,value: values.value as! String)
                    
                    self.requestListModel.append(requeslistt)
                }
                dump(requestListModel)
            }
        }) { error in
            print("Failed to read value: \(error.localizedDescription)")
        }
        
        
    }
    func handleRequestResponse(accept: Bool) {
        
        
        let newValue = accept ? "request_accepted" : "request_declined"
        
        ref.child("request_list").child(requestUpdateKey).setValue(newValue) { error, _ in
            if let error = error {
                print("Error updating request status: \(error.localizedDescription)")
            } else {
                print("Request \(accept ? "accepted" : "declined") successfully.")
                self.showAlertForAcceptRequest = false
                if accept {
                    self.navigateToChat = true
                }
            }
        }
    }
    
    
}

#Preview {
    LandMarkList()
}

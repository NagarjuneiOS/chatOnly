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
import FirebaseStorage


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
    @State var ProfileImage: UIImage? = UIImage(named: "profile")
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerPresented = false
    @State private var imageOptionSelected = false
    @State private var imageUrl = ""
    var ref: DatabaseReference! = Database.database().reference() // Initialize Firebase Database reference
    @State var firestorage = Storage.storage()
    @State var validationAlert = false
    @State var isLoading = false
    var body: some View {
      
            NavigationStack{
                
                VStack(spacing: 0) {
                    
                    
                    
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
                    .background(Color.pink.opacity(0.2))
                    .padding(.top,0)
                    
                    ZStack{
                        LinearGradient(colors: [Color.pink.opacity(0.2),Color.purple.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                        
                            .ignoresSafeArea()
                        
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
                                         .padding(.horizontal, 10)
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
                                         .padding(.horizontal, 10)
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
                                         .padding(.horizontal, 10)
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
                                        .padding(.horizontal, 10)
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
                                         .padding(.horizontal, 10)
                                            .frame(height: 50) // Increased height for username field
                                            .background(Color(.systemGray6)) // Optional background color
                                            .cornerRadius(8)
                                        
                                            .padding()
                                    }
                                    
                                    
                                }
                                
                                VStack(spacing: -20){
                                    HStack{
                                        Text("Profile picture")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding()
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                    ZStack{
                                        
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 200, height: 200)
                                        Image(uiImage: ProfileImage!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 200,height: 200)
                                            .clipShape(Circle())
                                        
                                        
                                        VStack{
                                            Spacer()
                                            HStack{
                                                Spacer()
                                                Button {
                                                    print("open gallery button tapped")
                                                    isImagePickerPresented = true
                                                } label: {
                                                    Image("upload")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                }

                                                .actionSheet(isPresented: $isImagePickerPresented) {
                                                               ActionSheet(
                                                                   title: Text("Select Image Source"),
                                                                   buttons: [
                                                                       .default(Text("Camera")) {
                                                                           sourceType = .camera
                                                                           self.imageOptionSelected = true
                                                                       },
                                                                       .default(Text("Photo Library")) {
                                                                           sourceType = .photoLibrary
                                                                           self.imageOptionSelected = true

                                                                       },
                                                                       .cancel()
                                                                   ]
                                                               )
                                                           }
                                                .sheet(isPresented: $imageOptionSelected) {
                                                                // Use UIImagePickerController with the selected source type
                                                    UnifiedImagePicker(selectedImage: $ProfileImage, isPresented: $imageOptionSelected, sourceType: sourceType)

                                                            }
                                                // Loading
                                                
                                                
                                            }
                                       
                                        }
                                        .frame(width: 200,height: 200)
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                print("Register button tapped")
                                
                                self.checkValidity { Bool in
                                    if Bool{
                                        self.checkAuthentication { Bool in
                                            if Bool{
                                                self.isLoading = true
                                                self.uploadIMage()
                                                self.isShowAlert = false
                                                
                                            }else{
                                                self.isShowAlert = true
                                                self.isLoading = false
                                                
                                            }
                                        }
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
                      
                                  
                        .alert(self.alertTitle, isPresented: $validationAlert) {
                            Button {
                                
                            } label: {
                                Text("OK")
                            }
                        }message:{
                            Text(alertMsg)
                                .bold()
                        }
                        
                        
                        .alert(isPresented: $navigationAlert) {
                            Alert(title: Text(alertTitle),message: Text(alertMsg),dismissButton: .default(Text("Ok"), action: {
                                UserDefaults.standard.set(self.number, forKey: "login_number")
                                UserDefaults.standard.set("true", forKey: "loggedin")
                                self.navigateToChat = true
                            }) )
                        }
                        if isLoading {
                            LoaderVC() // Show loader when isLoading is true
                        }
                    }
                }
            }

            .navigationDestination(isPresented: $navigateToChat, destination: {
                LandMarkList()
            })
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                self.fetchUserDetails()
                firestorage = Storage.storage(url: firebasestorageURL)
            }
        
    }
    
    func checkAuthentication(_ completion:(Bool) -> ()){
        if self.arrOfUserPhoneNumbers.contains(number){
            completion(false)

        }else{
            completion(true)
        }
        
        
    }
    
    func checkValidity(_completion: @escaping (Bool) -> Void){
        if number.count != 10{
            alertMsg = "Please enter valid number to be ten digits"
            validationAlert = true
            _completion(false)
        }else if passWord != confirmPassword{
            alertMsg = "Please enter the same password"
            validationAlert = true
            _completion(false)
        }else if firstName == ""{
            alertMsg = "Please enter the first name"
            validationAlert = true
            _completion(false)
        }else if lastName == ""{
            alertMsg = "Please enter the last name"
            validationAlert = true
            _completion(false)
        }
        else if ProfileImage == UIImage(named: "profile"){
            alertMsg = "Please upload the profile picture"
            validationAlert = true
        }else{
            _completion(true)

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
            "timestamp": Date().description,
            "imageurl": imageUrl
        ] as [String : Any]
        
        ref.child("users").child("\(firstName)_\(number)").setValue(userData){ error, _ in
            if let error = error{
                print(error)
            }else{
                print("User registered success")
                isLoading = false
                self.navigationAlert = true
                self.alertMsg = "Your registration seems successful"
            }
            
        }
        
    }
    func uploadIMage(){
        let imageData = ProfileImage?.jpegData(compressionQuality: 1.0)
        let firebaseStroageRef = self.firestorage.reference()
        let iamgeRef = firebaseStroageRef.child("user_profile_images").child("\(firstName)_\(number)").child("\(firstName)_\(number).jpg")
        iamgeRef.putData(imageData!){ data, error in
            print("Image uploaded")
            
            
            iamgeRef.downloadURL { url,error in
                if let error = error{
                    print(error)
                }else if let url = url{
                    print(url)
                    self.imageUrl = url.absoluteString
                    self.registerUser()
                }
            }
        }
        
    }
    
    
}

#Preview {
    RegisterView()
}
struct UnifiedImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    var sourceType: UIImagePickerController.SourceType
    
    // Coordinator to handle the image picker delegate
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: UnifiedImagePicker
        
        init(parent: UnifiedImagePicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType // Set the source type dynamically
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


struct LoaderVC: View {
    // MARK: - Properties
    @State private var showSpinner:Bool = true
    @State private var degree:Int = 270
    @State private var spinnerLength = 0.6
    
    // MARK: - Body
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                        .ignoresSafeArea()
                    if showSpinner{
                        Circle()
                            .trim(from: 0.0,to: spinnerLength)
                            .stroke(LinearGradient(colors: [.red,.blue], startPoint: .topLeading, endPoint: .bottomTrailing),style: StrokeStyle(lineWidth: 8.0,lineCap: .round,lineJoin:.round))
                            .animation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true))
                            .frame(width: 60,height: 60)
                            .rotationEffect(Angle(degrees: Double(degree)))
                            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                            .onAppear{
                                degree = 270 + 360
                                spinnerLength = 0
                            }
                    }
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderVC()
    }
}

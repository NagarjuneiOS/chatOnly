import SwiftUI
import PhotosUI
import Firebase
import FirebaseDatabase
import FirebaseStorage
struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
   // @Environment(\.presentationMode) var dismiss
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var password: String
    @Binding var phoneNumber: String
     
    @State private var showImagePicker = false
    @State private var profilepic: UIImage? = UIImage(named: "profile") // Placeholder image
    @State private var openProfile: Bool = false
    @Binding var profilePicUlr: String
     var referredProfilePicUlr: String
     var referencedFirstName: String
    @State var showAlertForUpdate = false
    @State var deleteAccountAlert: Bool = false
    @State var homeAlert: Bool = false
    @State var navigationAlert = false
    @State var isBackPressed = false
    
    
    @State private var activeField: String = "" // Track the active field
    @State private var selectedSource : UIImagePickerController.SourceType = .photoLibrary
    var daataBase: DatabaseReference! = Database.database().reference()
    var fireBaseStorage: StorageReference! = Storage.storage().reference()
    
    var body: some View {
        NavigationStack{
           
            ZStack{
                
                LinearGradient(colors: [Color.pink.opacity(0.2),Color.purple.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                VStack(spacing: -10){
                    HStack{
                        Button {
                            isBackPressed = true
                        } label: {
                            Image("back")
                                .resizable()
                                .frame(width: 40,height: 40)
                        }

                        
                        
                        
                        Text("Profile")
                            .font(.title)
                            .padding()
                        Spacer()
                        
                    }
                    .frame(height: 20)
                    .padding()
                ScrollView{
                    VStack {
                        ZStack {
                            
                            Button {
                                print("profile pic tapped")
                                self.openProfile.toggle()
                            } label: {
                                AsyncImage(url: URL(string: profilePicUlr)){ data in
                                    switch data {
                                    case .empty:
                                        Image(uiImage: profilepic!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 175, height: 175)
                                            .clipShape(Circle())
                                        
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 175, height: 175)
                                            .clipShape(Circle())
                                    case .failure(let error):
                                        Image(uiImage: profilepic!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 175, height: 175)
                                            .clipShape(Circle())
                                    @unknown default:
                                        EmptyView()
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                            
                            
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    Button {
                                        print("Edit Button Tapped")
                                        self.showActionSheet()
                                    } label: {
                                        Image("upload")
                                            .resizable()
                                            .frame(width: 30,height: 30)
                                            .padding(.vertical,10)
                                    }
                                    
                                }
                                
                            }
                            .frame(width: 150,height: 150)
                            
                        }
                        
                        
                        
                        VStack(spacing: -20) {
                            // Pass bindings to each nameFields instance with identifiers
                            nameFields(values: $firstName, titles: "First Name", identifier: "first", activeField: $activeField)
                            
                            nameFields(values: $lastName, titles: "Last Name", identifier: "last", activeField: $activeField)
                            nameFields(values: $password, titles: "Password", identifier: "password", activeField: $activeField)
                            nameFields(values: $phoneNumber, titles: "Phone Number", identifier: "number", activeField: $activeField)
                            
                       
                          
                        }
                        Button{
                            self.showAlertForUpdate = true
                        }label: {
                            Text("Update")
                            
                                .font(.callout)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity) // Expands button horizontally
                                .frame(height: 50) // Sets height to 50
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                                .padding()
                        }
                        .alert("Chat only", isPresented: $showAlertForUpdate) {
                            Button {
                                self.fireBaseStoreImaegeUdpate()
                            } label: {
                                Text("Ok")
                                    .font(.callout)
                                    .bold()
                            }
                            Button {
                                
                            } label: {
                                Text("cancel")
                                    .font(.callout)
                                    .bold()
                            }

                        }message:{
                            Text("Are you sure you want to update your profile picture")
                                .bold()
                        }
                            
                        Button{
                            self.deleteAccountAlert = true

                        }label: {
                            Text("Delete account")
                            
                                .font(.callout)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity) // Expands button horizontally
                                .frame(height: 50) // Sets height to 50
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                                .padding()
                        }
                        .alert("Chat only", isPresented: $deleteAccountAlert) {
                            Button {
                                self.homeAlert = true
                                self.deleteAccoint()
                            } label: {
                                Text("Ok")
                                    .font(.callout)
                                    .bold()
                            }
                            Button {
                                
                            } label: {
                                Text("cancel")
                                    .font(.callout)
                                    .bold()
                            }

                        }message:{
                            Text("Are you sure you want to delete your account?")
                                .bold()
                        }
                       
                       
                        .alert("Chat only", isPresented: $homeAlert) {
                            Button {
                                self.navigationAlert = true
                            } label: {
                                Text("Ok")
                                    .font(.callout)
                                    .bold()
                            }

                        }message:{
                            Text("Account deleted successfully")
                                .bold()
                        }
                        .navigationDestination(isPresented: $navigationAlert) {
                            NewWelcomeView()
                        }
                       
                        
                        Spacer()
                        
                        
                    }
                    
                    
                    .padding()
                    
                    
                }
                .navigationBarHidden(true) // Hide the navigation ba
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: selectedSource, selectedImage: $profilepic,profilePicUrl: $profilePicUlr)
                }
               
                       
            }
                // Fullscreen Profile Viewer
                if self.openProfile {
                    openImageVIew(profilePic: $profilepic, showView: $openProfile)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
    }
           
            .onAppear(){
                print(referredProfilePicUlr)
                print(profilePicUlr)
            }
           
            // Navigate back manually using isBackPressed flag
                        .onChange(of: isBackPressed) { _ in
                            if isBackPressed {
                                // Use this block to programmatically manage navigation here
                                dismiss() // Dismiss the current view if it's inside a sheet, or handle accordingly in your Navigation Stack
                            }
                        }
//                        .navigationDestination(isPresented: $navigationAlert) {
//                            NewWelcomeView()
//                        }
}
       
        .navigationBarBackButtonHidden(true)
        
    }
   // Show action sheet for choosing Camera or Gallery
        private func showActionSheet() {
            let alert = UIAlertController(title: "Edit Profile Photo", message: "Choose an option", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                selectedSource = .camera
                showImagePicker = true
            })
            alert.addAction(UIAlertAction(title: "Gallery", style: .default) { _ in
                selectedSource = .photoLibrary
                showImagePicker = true
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            // Present the alert
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(alert, animated: true)
            }
        }
    
    
    func fireBaseStoreImaegeUdpate() {
        print(referredProfilePicUlr)
        print(profilePicUlr)
        let storage = Storage.storage().reference(forURL: referredProfilePicUlr)
        storage.delete { error in
            if let error = error {
                
            }else{
                print("delete successful")
                self.uploadIMage()
            }
        }
        
            
        
    }
    func deleteAccoint(){
        var nodeKey = "\(self.referencedFirstName)_\(self.phoneNumber)"
        self.daataBase?.child("users").child(nodeKey).removeValue(completionBlock: { error, ref in
            if let error = error {
                
            }else{
                print("delete success")
            }
        })
    }
    
        func uploadIMage(){
            let imageData = profilepic?.jpegData(compressionQuality: 1.0)
            let firebaseStroageRef = self.fireBaseStorage
            let iamgeRef  = firebaseStroageRef?.child("user_profile_images").child("\(firstName)_\(phoneNumber)").child("\(firstName)_\(phoneNumber).jpg")
            iamgeRef?.putData(imageData!){ data, error in
                print("Image uploaded")
                
                
                iamgeRef?.downloadURL { url,error in
                    if let error = error{
                        print(error)
                    }else if let url = url{
                        print(url)
                        self.updateDate(st: url.absoluteString)
                    }
                }
            }
            
        }
    
    func deleteAccount() {
        var nodeKey = "\(self.referencedFirstName)_\(self.phoneNumber)"
        var newNodeKey = "\(self.firstName)_\(self.phoneNumber)"
        self.daataBase.child("users").child(nodeKey).removeValue { Error, ref in
            if let error = Error {
                print("Error removing user: \(error)")
            }else{
            }
        }
    }
    func updateDate(st:String) {
        let userData = [
            "firstname" : firstName,
            "lastname": lastName,
            "phonenumber": phoneNumber,
            "password" : password,
            "timestamp": Date().description,
            "imageurl": st
        ] as [String : Any]
        var nodeKey = "\(self.referencedFirstName)_\(self.phoneNumber)"
        var newNodeKey = "\(self.firstName)_\(self.phoneNumber)"
        self.daataBase.child("users").child(nodeKey).removeValue { Error, ref in
           if let error = Error {
                print("Error removing user: \(error)")
           }else{
               self.daataBase.child("users").child(newNodeKey).setValue(userData) { error, rerference in
                   if let error = error {
                       print("Error adding user: \(error)")
                   }else{
                       print("user data addded successfully")
                   }
               }
           }
        }
    }
    
}

#Preview {
    ProfileView(firstName: .constant(""), lastName: .constant(""), password: .constant(""), phoneNumber: .constant(""), profilePicUlr: .constant(""), referredProfilePicUlr: "", referencedFirstName: "")
}

struct nameFields: View {
    @Binding var values: String // Bind the TextField value
    var titles: String = ""
    var identifier: String // Unique identifier for the field
    @Binding var activeField: String // Track the active field in parent
    @State var isActive = false
    
    var body: some View {
        VStack(spacing: -20) {
            HStack {
                Text(titles)
                
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding()
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 25) // Rounded corners
                    .fill(Color.white)
                    .frame(height: 50)
                    //.shadow(color: Color.pink.opacity(0.5), radius: 2, x: 2, y: 2) // Elevation effect
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.pink) // Border with corner radius
                    )
                    
                    .padding()
                
                HStack {
                    TextField("", text: $values) // Bind the TextField to the parent state
                        .padding(.leading, 30)
                        .disabled(!isActive)
                        .foregroundColor(isActive ? .black : .gray)
                        
                        
                        
                    
                    Button {
                        activeField = identifier // Update the active field when tapped
                        print("\(identifier) edit tapped")
                        self.isActive.toggle()
                    } label: {
                        if identifier != "number"{
                            
                            if isActive{
                            Image("check")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 20)
                        }else{
                            Image("nameedit")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 20)
                        }
                    }
                      
                    }
                }
            }
        }
        
    }
}

#Preview(body: {
    nameFields(values: .constant(""), identifier: "First Name", activeField: .constant(""))
})
// Helper struct for Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Binding var profilePicUrl: String
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.profilePicUrl =  self.saveImageToDocumentsDirectory(image: image)!.absoluteString
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        // Save the image to a directory and return its URL
           private func saveImageToDocumentsDirectory(image: UIImage) -> URL? {
               guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
               
               let fileManager = FileManager.default
               let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
               let fileURL = directory.appendingPathComponent(UUID().uuidString + ".jpg")
               
               do {
                   try data.write(to: fileURL)
                   return fileURL
               } catch {
                   print("Error saving image: \(error)")
                   return nil
               }
           }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct openImageVIew: View{
    @Binding var profilePic: UIImage?
    @Binding var showView: Bool
    var body: some View{
        ZStack{
            
            Rectangle()
                .fill(Color.gray.opacity(0.8))
                .onTapGesture {
                    showView.toggle()
                }
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(maxWidth: 250,maxHeight: 250)
                Image(uiImage: profilePic!)
                    .resizable()
                    .shadow(color: .white, radius: 20)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 250,maxHeight: 250)
                    
                    .padding()
                    .ignoresSafeArea()
                
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        
        
    }
}
#Preview{
    openImageVIew(profilePic: .constant(UIImage(named: "profile")), showView: .constant(false))
}

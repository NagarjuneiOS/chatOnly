//
//  LandmarkView.swift
//  SwiftUiListViewBasics
//
//  Created by Nagarjune on 21/10/24.
//

import SwiftUI

struct LandmarkView: View {
   // var ladmarks: Landmark
    var userData: UsersModel
    @State private var isLoading = true // Track loading state

    var body: some View {
        
        ZStack{
            LinearGradient(colors: [Color.pink.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                           
            HStack{
               
                    
                
                AsyncImage(url: URL(string:userData.imageurl ?? "")) { phase in
                    switch phase {
                    case .empty:
                                       
                       
                        Image("profile")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .padding(.leading, 15)
                        
                    case .success(let image):
                        // Once the image is loaded, show it
                       
                        image.resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .padding(.leading, 15)
                        
                    case .failure:
                        // Show a fallback image when loading fails
                        
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .padding(.leading, 15)

                    @unknown default:
                        EmptyView()
                    }
                }
            
            VStack(alignment: .leading,spacing: 0){
                Text(userData.firstName ?? "" + (userData.lastName ?? ""))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Text("")
                    .fontWeight(.light)
                
            }
            // .foregroundColor(Color.white)
            
            .padding(EdgeInsets(top: 0, leading: 0, bottom:  0, trailing: 0))
            
            Spacer()
            VStack(){
                Text(convertToDate(userData.timeStamp!))
                    .fontWeight(.light)
                    .font(.subheadline)
    
            }
            .padding()
            
            
            
        }
        
        .frame(height: 80)
        .padding(EdgeInsets(top: 0, leading: 0, bottom:  0, trailing: 15))
            
        
    }
        

    }
    
    func convertToDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        // Use lowercase 'yyyy' for year and 'mm' for minutes
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        // Add timezone handling (optional: assuming UTC if no timezone is provided)
           formatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "hh:mm a" // To convert to 12-hour format with AM/PM
            return formatter.string(from: date)
        } else {
            return "Invalid date format" // Handle invalid date format
        }
    }

}

#Preview {
    LandmarkView(userData: UsersModel())
    
       
}

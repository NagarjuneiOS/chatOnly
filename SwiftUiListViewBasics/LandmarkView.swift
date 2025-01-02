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
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [Color.pink.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                           
        HStack{
            Image(.charleyrivers)
                .resizable()
                .clipShape(.circle)
                .frame(width: 50,height: 50)
                .padding(EdgeInsets(top: 0, leading: 15, bottom:  0, trailing: 0))
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
                Text("1.45 am")
                    .fontWeight(.light)
                    .font(.subheadline)
                
                //                        if self.ladmarks.name == "Twin Lake" || self.ladmarks.name == "Silver Salmon Creek"{
                //                            Text("1")
                //                                .font(.system(size: 15, weight: .bold)) // Make the text larger and bold
                //                                .foregroundColor(.white) // Set text color to white
                //                                .padding(.horizontal, 10) // Horizontal padding for rounded effect
                //                                .padding(.vertical, 5) // Vertical padding for height
                //                                .background(Circle().fill(Color.green))
                //                             //   .padding()
                //                        }
            }
            .padding()
            
            
            
        }
        
        .frame(height: 80)
        .padding(EdgeInsets(top: 0, leading: 0, bottom:  0, trailing: 15))
            
        
    }
        

    }
}

#Preview {
    LandmarkView(userData: UsersModel())
    
       
}

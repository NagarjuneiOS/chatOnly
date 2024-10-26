//
//  LandmarkView.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 21/10/24.
//

import SwiftUI

struct LandmarkView: View {
    var ladmarks: Landmark
    
    var body: some View {
    
            
                HStack{
                    Image(.charleyrivers)
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 50,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom:  0, trailing: 0))
                    VStack(alignment: .leading,spacing: 0){
                        Text(ladmarks.name)
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Text("Hi, are you coming Today")
                            .fontWeight(.light)
                        
                    }
                   // .foregroundColor(Color.white)

                    .padding(EdgeInsets(top: 0, leading: 0, bottom:  0, trailing: 0))

                    Spacer()
                    VStack(){
                        Text("1.45 am")
                            .fontWeight(.light)
                            .font(.subheadline)
                        
                        if self.ladmarks.name == "Twin Lake" || self.ladmarks.name == "Silver Salmon Creek"{
                            Text("1")
                                .font(.system(size: 15, weight: .bold)) // Make the text larger and bold
                                .foregroundColor(.white) // Set text color to white
                                .padding(.horizontal, 10) // Horizontal padding for rounded effect
                                .padding(.vertical, 5) // Vertical padding for height
                                .background(Circle().fill(Color.green))
                             //   .padding()
                        }
                    }
                    .padding()
                 
                  
                        
                }
                .frame(height: 70)
                .padding(EdgeInsets(top: 0, leading: 0, bottom:  0, trailing: 0))

          
        

    }
}

#Preview {
    LandmarkView(ladmarks: landMarks[0])
    
       
}

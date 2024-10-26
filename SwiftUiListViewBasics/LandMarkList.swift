//
//  LandMarkList.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 22/10/24.
//

import SwiftUI

struct LandMarkList: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                HStack(){
                    Text("WhatsApp")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    HStack(spacing: 20) {
                        Image(systemName: "camera")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                        Image(systemName: "checkmark")
                            .padding()
                    }
                    
                }
                .padding(.top)
                Divider()
                List(landMarks, id: \.id){ landmarkss in
                    NavigationLink(destination: ChatVC()) {
                        LandmarkView(ladmarks: landmarkss)
                    }
                    .navigationBarBackButtonHidden(true)
                    
                }
                .listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -20))
            }
        }
    }
        
}

#Preview {
    LandMarkList()
}

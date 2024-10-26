//
//  ReceiverMsgVieew.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 26/10/24.
//

import SwiftUI

struct ReceiverMsgVieew: View {
    var msg: String? = " A paraphrase or rephrase is the rendering of the same text in different words without losing the meaning of the text itself. More often than not, a paraphrased text can convey its meaning better than the original words. In other words, it is a copy of the text in meaning,"
    var body: some View {
        
        HStack{
            
            Text(self.msg ?? "")
                .padding(.horizontal,10)
                .padding(.vertical,10)
                .background(Color.cyan)
                .cornerRadius(10)
                .foregroundStyle(Color.white)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 0 , leading: 10, bottom: 0, trailing: 0))

    

            
    
    }
        
}

#Preview {
    ReceiverMsgVieew()
}

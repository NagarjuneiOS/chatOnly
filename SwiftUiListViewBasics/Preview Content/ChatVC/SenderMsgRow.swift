//
//  SenderMsgRow.swift
//  SwiftUiListViewBasics
//
//  Created by Nagarjune on 25/10/24.
//

import SwiftUI

struct SenderMsgRow: View {
    var msg: String? = " A paraphrase or rephrase is the rendering of the same text in different words without losing the meaning of the text itself. More often than not, a paraphrased text can convey its meaning better than the original words. In other words, it is a copy of the text in meaning,"
    var body: some View {
        HStack{
            Spacer()
            
            Text(self.msg ?? "")
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(Color.cyan)
                .cornerRadius(10)
                .foregroundStyle(Color.white)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing) // Maximum width
        }

       .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))

            
    
    }
}

#Preview {
    SenderMsgRow()
}

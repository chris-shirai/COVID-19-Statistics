//
//  CasesStatView.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

let blueColor = Color(red: 91/255, green: 160/255, blue: 191/255)
let peachColor = Color(red: 251/255, green: 116/255, blue: 136/255)
let purpleColor = Color(red: 126/255, green: 98/255, blue: 123/255)
let orangeColor = Color(red: 227/255, green: 134/255, blue: 100/255)



struct CasesStatView: View {
    
    let text: String
    let totalCountText: String
    let color: Color
    var height: CGFloat? = nil
    
    
    var body: some View {
        VStack{
            Text(totalCountText)
                .font(.system(size: 16, weight: .semibold))
            Text(text)
                .font(.system(size: 16, weight: .regular))
        }
        .lineLimit(1)
        .minimumScaleFactor(0.7)
        .foregroundColor(.white)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: height)
        .background(color)
    }
}

struct CasesStatView_Previews: PreviewProvider {
    static var previews: some View {
        CasesStatView(text: "confirmed", totalCountText: "100", color: blueColor)
            .previewContext(WidgetPreviewContext(family:.systemSmall))
    }
}

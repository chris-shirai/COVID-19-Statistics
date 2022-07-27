//
//  CasesStatView.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

let confirmed = Color(red: 71/255, green: 97/255, blue: 244/255)
let death = Color(red: 244/255, green: 144/255, blue: 144/255)
let recovered = Color(red: 60/255, green: 21/255, blue: 152/255)
let sick = Color(red: 253/255, green: 131/255, blue: 68/255)

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
        CasesStatView(text: "confirmed", totalCountText: "100", color: confirmed)
            .previewContext(WidgetPreviewContext(family:.systemSmall))
    }
}

//
//  TitleDateHeader.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

struct TitleDateHeader: View {
    
    let title: String
    let date: Date
    var body: some View {
        HStack{
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            Text(date, style: .time)
        }.lineLimit(1)
            .minimumScaleFactor(0.7)
    }
}

struct TitleDateHeader_Previews: PreviewProvider {
    static var previews: some View {
        TitleDateHeader(title: "Global", date: Date())
            .previewContext(WidgetPreviewContext(family:.systemSmall))
    }
}

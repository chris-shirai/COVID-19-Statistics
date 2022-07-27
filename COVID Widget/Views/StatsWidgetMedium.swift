//
//  StatsWidgetMedium.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

struct StatsWidgetMedium: View {



    var body: some View {
        VStack(spacing: 0) {
            TitleDateHeader(title: "test", date: Date())
                .padding(.vertical, 4)
                .padding(.horizontal)
            CaseStatGrid()
        }

    }
}

struct StatsWidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        StatsWidgetMedium()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

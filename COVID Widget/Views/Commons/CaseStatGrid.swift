//
//  CaseStatGrid.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

struct CaseStatGrid: View {
    
//    let totalCount: Total
    let columns: [GridItem] = [
        .init(.flexible(), spacing: 0),
        .init(.flexible(), spacing: 0)
    ]
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                LazyVGrid(columns: columns, spacing: 0){
                    CasesStatView(text: "test", totalCountText: "100", color: death, height: proxy.size.height / 2)
                    CasesStatView(text: "test", totalCountText: "100", color: confirmed, height: proxy.size.height / 2)
                    CasesStatView(text: "test", totalCountText: "100", color: sick, height: proxy.size.height / 2)
                    CasesStatView(text: "test", totalCountText: "100", color: recovered, height: proxy.size.height / 2)
                }
            }
        }
        
    }
}

struct CaseStatGrid_Previews: PreviewProvider {
    static var previews: some View {
        CaseStatGrid()
            .previewContext((WidgetPreviewContext(family: .systemMedium)))
    }
}

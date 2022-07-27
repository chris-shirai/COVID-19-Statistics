//
//  HelloWidgetView.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/1/22.
//

import SwiftUI

struct HelloWidgetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello")
            Text("DevTechie!")
                .bold()
                .foregroundColor(.orange)
                .font(.title)
        }.font(.title3)
    }
}

struct HelloWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        HelloWidgetView()
    }
}

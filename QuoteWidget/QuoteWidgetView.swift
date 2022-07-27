//
//  QuoteWidgetView.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/2/22.
//

import SwiftUI

struct QuoteWidgetView: View {
    let entry: QuoteWidgetEntry
    
    var body: some View {
        VStack {
            Text(entry.quote.quoteText)
            HStack {
                Spacer()
                Text("-" + entry.quote.quoteAuthor)
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            Text(entry.date.formatted(date: .omitted, time: .shortened))
                .font(.caption)
                .foregroundColor(.secondary)
        }.padding()
    }
}

//
//  QuoteWidgetTimelineProvider.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/2/22.
//

import WidgetKit

struct QuoteWidgetTimelineProvider: TimelineProvider {
    typealias Entry = QuoteWidgetEntry
    
    let placeholderQuote = Quote(quoteText: "Nothing in life is to be feared. It is only to be understood.", quoteAuthor: "Marie Curie")
    
    func placeholder(in context: Context) -> QuoteWidgetEntry {
        QuoteWidgetEntry(date: Date(), quote: placeholderQuote)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (QuoteWidgetEntry) -> Void) {
        completion(QuoteWidgetEntry(date: Date(), quote: placeholderQuote))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteWidgetEntry>) -> Void) {
        QuoteService().getRandomQuote { result in
            let quote: Quote
            
            switch result {
            case .success(let fetched):
                quote = fetched
                
            case .failure(let err):
                quote = Quote(quoteText: "\(err.localizedDescription)", quoteAuthor: "Error")
            }
            
            let entry = QuoteWidgetEntry(date: Date(), quote: quote)
            
            let timeline = Timeline(entries: [entry], policy: .after(Calendar.current.date(byAdding: .minute, value: 1, to: Date())!))
            
            completion(timeline)
        }
    }
}

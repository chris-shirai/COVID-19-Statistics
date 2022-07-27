//
//  HelloWidgetTimelineProvider.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/1/22.
//

import WidgetKit

struct HelloWidgetTimelineProvider: TimelineProvider {
    
    typealias Entry = HelloWidgetEntry
    
    func placeholder(in context: Context) -> HelloWidgetEntry {
        HelloWidgetEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (HelloWidgetEntry) -> Void) {
        completion(HelloWidgetEntry())
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<HelloWidgetEntry>) -> Void) {
        completion(Timeline(entries: [HelloWidgetEntry()], policy: .never))
    }
}

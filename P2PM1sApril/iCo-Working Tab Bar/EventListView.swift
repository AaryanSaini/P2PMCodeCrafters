//
//  EventListView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import SwiftUI

// Event List View
struct EventListView: View {
    @StateObject private var viewModel = EventDataModel.shared
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) { // Increased gap between cards
                ForEach(viewModel.events) { event in
                    EventCardView(event: event)
                }
            }
            .padding()
        }
        .navigationTitle("Events")
    }
}

// Preview
struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventListView()
        }
    }
}

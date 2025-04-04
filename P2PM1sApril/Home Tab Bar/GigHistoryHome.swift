//
//  GigHistoryHome.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import SwiftUI

struct GigHistoryHome: View {
    let title: String
    let gigs: [Gig]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            List(gigs) { gig in
                VStack(alignment: .leading) {
                    Text(gig.title)
                        .font(.headline)
                        .foregroundColor(Color(hex: "262860"))
                    Text(gig.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}


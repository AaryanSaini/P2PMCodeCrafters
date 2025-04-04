//
//  EventCardView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import SwiftUI
// Event Card View
struct EventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Event Image
            Image(event.eventImage)
                .resizable()
                .frame(width: 160, height: 102)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Date & Time View
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.blue.opacity(0.1))
                .frame(width: 151, height: 17)
                .overlay(
                    HStack(spacing: 4) {
                        Label(event.date, systemImage: "calendar")
                        Text("•")
                        Label(event.time, systemImage: "clock")
                        Text("•")
                        Label(event.location, systemImage: "mappin.and.ellipse")
                    }
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                )
            
            // Event Title
            Text(event.title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 2)
            
            // Workspace Info & Book Button
            HStack {
                Image(event.workspaceLogo)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .clipShape(Circle())
                
                Text(event.workspace)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: { event.bookEvent() }) {
                    Text("Book")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 60, height: 25)
                        .background(Color(hex: "262860"))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
        .padding(8)
        .frame(width: 160, height: 171)
        .background(Color(hex: "262860").opacity(0.05)) // Applied color to card only
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

//struct EventCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventCardView()
//    }
//}

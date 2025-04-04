//
//  BookingHistoryView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import SwiftUI

struct BookingHistoryView: View {
    @AppStorage("bookings") private var bookingsData: Data = Data()
    @State private var selectedSegment = "Workspace"
    let segments = ["Workspace", "Events"]
    
    var body: some View {
        VStack {
            Picker("Select", selection: $selectedSegment) {
                ForEach(segments, id: \ .self) { segment in
                    Text(segment).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List(loadBookings()) { booking in
                VStack(alignment: .leading) {
                    Text(booking.workspaceName)
                        .font(.headline)
                    Text("Date: \(booking.selectedDate, formatter: dateFormatter)")
                    Text("Persons: \(booking.numberOfPersons)")
                    Text("Time: \(booking.startTime, formatter: timeFormatter) - \(booking.endTime, formatter: timeFormatter)")
                }
                .padding()
            }
        }
        .navigationTitle("Booking History")
    }
    
    private func loadBookings() -> [Booking] {
        if let decoded = try? JSONDecoder().decode([Booking].self, from: bookingsData) {
            return decoded
        }
        return []
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView(workspaceName: "Data Passing")
//    }
//}

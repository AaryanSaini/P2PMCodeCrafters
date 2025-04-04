import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: String
    let location: String
    let eventImage: String
    let workspace: String
    let workspaceLogo: String
    
    func bookEvent() {
        print("Booked event: \(title)")
    }
}

// Event Data Model
class EventDataModel: ObservableObject {
    static let shared = EventDataModel()
    
    @Published var events: [Event] = []
    
    private init() {
        events = [
            Event(title: "Tech Event", date: "Fri, July 20", time: "10:00 AM", location: "Mohali", eventImage: "event1", workspace: "Ace Space", workspaceLogo: "workspace1"),
            Event(title: "AI Workshop", date: "Mon, Aug 15", time: "2:00 PM", location: "Chandigarh", eventImage: "event2", workspace: "Innovate Hub", workspaceLogo: "workspace2"),
            Event(title: "Startup Meetup", date: "Sat, Sep 10", time: "5:00 PM", location: "Pune", eventImage: "event3", workspace: "Cowork Connect", workspaceLogo: "workspace3")
        ]
    }
}


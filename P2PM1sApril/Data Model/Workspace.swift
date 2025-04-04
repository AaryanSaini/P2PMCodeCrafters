import SwiftUI
import Foundation
import CoreLocation

// Workspace Model
class Workspace: Identifiable {
    let id: UUID
    let name: String
    let distance: String
    let image: String
    let gigsOpen: String?
    let offer: String
    let price: String
    let features: [String]
    let coordinate: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), name: String, distance: String, image: String, gigsOpen: String?, offer: String, price: String, features: [String], coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.distance = distance
        self.image = image
        self.gigsOpen = gigsOpen
        self.offer = offer
        self.price = price
        self.features = features
        self.coordinate = coordinate
    }
}

// Workspace Data Model
class WorkspaceManager {
    static let shared = WorkspaceManager()
    
    private init() {}
    
    func getWorkspaces() -> [Workspace] {
        return [
            Workspace(name: "Busy Plus", distance: "950 meters away", image: "workspace1", gigsOpen: "3 Gigs Open", offer: "50% OFF on First Booking", price: "₹ 600 per day", features: ["Parking Available", "Commute friendly"], coordinate: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)),
            
            Workspace(name: "We Work", distance: "1.2 kms away", image: "workspace2", gigsOpen: nil, offer: "Unlimited Free Bookings", price: "₹ 600 per day", features: ["Parking Available"], coordinate: CLLocationCoordinate2D(latitude: 12.9352, longitude: 77.6245)) 
        ]
    }
}

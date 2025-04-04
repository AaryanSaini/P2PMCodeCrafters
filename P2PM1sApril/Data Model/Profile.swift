import UIKit

// Data Model for Profile Information
struct Profile {
    var name: String
    var role: String
    var image: UIImage?
    var email: String
    var phone: String
}

// Observable Data Model for Profile Screen
class ProfileViewModel: ObservableObject {
    @Published var profile = Profile(
        name: "Abhay Singh",
        role: "iOS Developer",
        image: nil,
        email: "abhay@example.com",
        phone: "+91 9876543210"
    )

    @Published var settings: [String] = [
        "About", "Personal Information", "My Connections",
        "Bookmark", "Bookings", "Appearance", "Privacy"
    ]

    // Function to Update Profile
    func updateProfile(name: String?, role: String?, image: UIImage?) {
        if let newName = name { profile.name = newName }
        if let newRole = role { profile.role = newRole }
        if let newImage = image { profile.image = newImage }
    }
}

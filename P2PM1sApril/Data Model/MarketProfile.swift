import Foundation

// Structure for Active Projects
struct ActiveProject: Identifiable {
    let id = UUID()
    let name: String
    let startDate: String
}

// Structure for Market Profile
struct MarketProfile: Identifiable {
    let id = UUID()
    let name: String
    let specialization: String
    let location: String
    let profileImage: String
    let connections: Int
    let jobsPosted: Int
    let jobsApplied: Int
    let activeProjects: [ActiveProject]
}

// Singleton Class to manage profiles
class MarketProfileManager {
    static let shared = MarketProfileManager()
    
    private init() {}
    
    let profiles: [MarketProfile] = [
        MarketProfile(
            name: "Abhay Singh",
            specialization: "iOS Developer",
            location: "Mohali",
            profileImage: "person1",
            connections: 800,
            jobsPosted: 30,
            jobsApplied: 15,
            activeProjects: [
                ActiveProject(name: "Location iOS", startDate: "Nov 2024 - Present"),
                ActiveProject(name: "Doctor Appointment iOS", startDate: "July 2024 - Present"),
                ActiveProject(name: "Fitness Tracker iOS", startDate: "Oct 2024 - Present")
            ]
        ),
        MarketProfile(
            name: "Aaryan Saini",
            specialization: "Mern Stack",
            location: "Chandigarh",
            profileImage: "person1",
            connections: 600,
            jobsPosted: 20,
            jobsApplied: 10,
            activeProjects: [
                ActiveProject(name: "E-commerce App", startDate: "Jan 2024 - Present"),
                ActiveProject(name: "Social Media Dashboard", startDate: "March 2024 - Present")
            ]
        ),
        MarketProfile(
            name: "Abhishek Bhardwaj",
            specialization: "iOS Developer",
            location: "Delhi",
            profileImage: "person1",
            connections: 800,
            jobsPosted: 40,
            jobsApplied: 20,
            activeProjects: [
                ActiveProject(name: "E-commerce App", startDate: "Jan 2024 - Present"),
                ActiveProject(name: "Social Media Dashboard", startDate: "March 2024 - Present")
            ]
        )
    ]
}

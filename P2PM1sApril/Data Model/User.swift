////
////  User.swift
////  P2PM1sApril
////
//import Foundation
//
//// Structure to represent a Gig
//struct Gig: Identifiable {
//    var id: UUID = UUID()  // Ensuring each gig has a unique ID
//    var title: String
//    var location: String
//    var jobType: String  // Example: "Full Time"
//    var salary: String   // Example: "₹900/hr"
//    var workMode: String // Example: "Remote"
//    var timePosted: String // Example: "12m ago"
//    var applicants: String // Example: "30+ Applied"
//    var experienceRequired: String // Example: "4 years +"
//    var workRole: String // Example: "Contributor"
//}
//
//// Structure to represent Gig History
//struct GigHistory {
//    var applied: Int  // Total applied gigs
//    var posted: Int   // Total posted gigs
//    var appliedGigs: [Gig] = []  // New property to store applied gigs
//    var postedGigs: [Gig] = []
//    // New property to store posted gigs
//}
//
//
//// Structure to represent a User
//struct User {
//    var id: UUID
//    var name: String
//    var gigHistory: GigHistory
//    var liveGigs: [Gig]
//    var appliedGigs: [Gig]
//    var postedGigs: [Gig]
//    mutating func applyForGig(gig: Gig) {
//        gigHistory.applied += 1
//        gigHistory.appliedGigs.append(gig)
//    }// NEW - Track posted gigs
//}
//
//
//
//// Singleton Class to manage User and Gig data
//class UserDataModel: ObservableObject {
//    @Published private(set) var users: [User] = []
//    static let shared = UserDataModel() // Singleton instance
//    
//   /* private var users: [User] = [] */ // Stores all users
//    private var gigs: [Gig] = []
////    @Published var user: User
//    // Stores all available gigs
////    init(user: User) {
////           self.user = user
////       }
//    
//    private init() {
//        // Sample Data Initialization
//        let sampleGig1 = Gig(
//            id: UUID(),
//            title: "Data Analyst",
//            location: "Mumbai, India",
//            jobType: "Contract",
//            salary: "₹1000/hr",
//            workMode: "Remote",
//            timePosted: "3 hours ago",
//            applicants: "50+ Applied",
//            experienceRequired: "3 years +",
//            workRole: "Analyst"
//        )
//        
//        let sampleGig2 = Gig(
//            id: UUID(),
//            title: "Frontend Developer",
//            location: "Bangalore, India",
//            jobType: "Full-time",
//            salary: "₹1200/hr",
//            workMode: "On-site",
//            timePosted: "1 day ago",
//            applicants: "30+ Applied",
//            experienceRequired: "2 years +",
//            workRole: "Web Developer"
//        )
//        
//        let sampleGig3 = Gig(
//            id: UUID(),
//            title: "Backend Developer",
//            location: "Delhi, India",
//            jobType: "Contract",
//            salary: "₹1500/hr",
//            workMode: "Remote",
//            timePosted: "5 hours ago",
//            applicants: "100+ Applied",
//            experienceRequired: "4 years +",
//            workRole: "Backend Engineer"
//        )
//        
//        let sampleGig4 = Gig(
//            id: UUID(),
//            title: "iOS Developer",
//            location: "Chennai, India",
//            jobType: "Full-time",
//            salary: "₹1800/hr",
//            workMode: "Hybrid",
//            timePosted: "2 days ago",
//            applicants: "20+ Applied",
//            experienceRequired: "3 years +",
//            workRole: "Mobile App Developer"
//        )
//        
//        let sampleGig5 = Gig(
//            id: UUID(),
//            title: "Machine Learning Engineer",
//            location: "Hyderabad, India",
//            jobType: "Internship",
//            salary: "₹500/hr",
//            workMode: "Remote",
//            timePosted: "6 hours ago",
//            applicants: "150+ Applied",
//            experienceRequired: "0-1 years",
//            workRole: "ML Engineer"
//        )
//        
//        let userGigHistory = GigHistory(applied: 0, posted: 0, appliedGigs: [], postedGigs: [])
//
//        
//        let sampleUser = User(
//            id: UUID(),
//            name: "Abhay Singh",
//            gigHistory: userGigHistory,
//            liveGigs: [sampleGig1, sampleGig2],
//            appliedGigs: [] ,// Ensure appliedGigs is explicitly set
//            postedGigs: []
//        )
//        
//        // Adding sample gigs and user
//        users.append(sampleUser)
//        gigs.append(contentsOf: [sampleGig1, sampleGig2, sampleGig3, sampleGig4, sampleGig5])
//    }
//    
//    // Method to get all users
//    func getAllUsers() -> [User] {
//          return users
//      }
//    
//    // Method to find a user by ID
//    func getUser(by id: UUID) -> User? {
//        return users.first { $0.id == id }
//    }
//    
//    // Method to get live gigs near a location
//    func getLiveGigsNear(location: String) -> [Gig] {
//        return gigs.filter { $0.location.lowercased() == location.lowercased() }
//    }
//    
//    // Method to get a user's gig history
//    func getGigHistory(for userId: UUID) -> GigHistory? {
//        return getUser(by: userId)?.gigHistory
//    }
//    
//    // Method to apply for a gig
//    func applyForGig(userId: UUID, gigId: UUID) {
//        guard let userIndex = users.firstIndex(where: { $0.id == userId }) else { return }
//        guard let gigIndex = users[userIndex].liveGigs.firstIndex(where: { $0.id == gigId }) else { return }
//
//        let appliedGig = users[userIndex].liveGigs.remove(at: gigIndex) // Remove from liveGigs
//        users[userIndex].gigHistory.appliedGigs.append(appliedGig) // Add to appliedGigs
//        
//        users[userIndex].gigHistory.applied += 1  // ✅ Increase applied gig count
//
//        objectWillChange.send() // Notify UI updates
//    }
//
//    
//    func addGig(userId: UUID, gig: Gig) {
//        guard let userIndex = users.firstIndex(where: { $0.id == userId }) else { return }
//        
//        users[userIndex].postedGigs.append(gig)
//        users[userIndex].gigHistory.posted += 1
//    }
//    
//    func editGig(userId: UUID, gigId: UUID, updatedGig: Gig) {
//        if let userIndex = users.firstIndex(where: { $0.id == userId }) {
//            if let gigIndex = users[userIndex].postedGigs.firstIndex(where: { $0.id == gigId }) {
//                users[userIndex].postedGigs[gigIndex] = updatedGig
//                objectWillChange.send() // Notify SwiftUI to refresh UI
//            }
//        }
//    }
//    
//    
//    
//    // Method to post a new gig
////    func postNewGig(userId: UUID, newGig: Gig) {
////        guard var user = getUser(by: userId) else { return }
////        
////        user.gigHistory.posted += 1
////        gigs.append(newGig)
////        
////        if let index = users.firstIndex(where: { $0.id == userId }) {
////            users[index] = user
////        }
////    }
//    func postNewGig(userId: UUID, newGig: Gig) {
//        if let index = users.firstIndex(where: { $0.id == userId }) {
//            users[index].postedGigs.append(newGig)
//            objectWillChange.send() // Notify SwiftUI that data has changed
//        }
//    }
//    var postedGigsCount: Int {
//         users.first?.postedGigs.count ?? 0
//     }
//    func deleteGig(userId: UUID, gigId: UUID) {
//        if let userIndex = users.firstIndex(where: { $0.id == userId }) {
//            users[userIndex].postedGigs.removeAll { $0.id == gigId }
//            objectWillChange.send() // Notify SwiftUI to update UI
//        }
//    }
//    
//    
//    
//}
//

import Foundation
import SwiftUI
import Combine

// MARK: - Structure to represent a Gig
// MARK: - Structure to represent a Gig
struct Gig: Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var location: String
    var jobType: String
    var salary: String
    var workMode: String
    var timePosted: String
    var applicants: String
    var experienceRequired: String
    var workRole: String
    
    static func == (lhs: Gig, rhs: Gig) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Structure to represent Gig History
struct GigHistory {
    var applied: Int = 0
    var posted: Int = 0
    var appliedGigs: [Gig] = []
    var postedGigs: [Gig] = []
}

// MARK: - Structure to represent a User
class User: ObservableObject {
    var id: UUID
    var name: String
    
    @Published var gigHistory: GigHistory
    @Published var liveGigs: [Gig]
    @Published var appliedGigs: [Gig]
    @Published var postedGigs: [Gig]
    
    init(id: UUID, name: String, gigHistory: GigHistory, liveGigs: [Gig], appliedGigs: [Gig], postedGigs: [Gig]) {
        self.id = id
        self.name = name
        self.gigHistory = gigHistory
        self.liveGigs = liveGigs
        self.appliedGigs = appliedGigs
        self.postedGigs = postedGigs
    }
    
    func applyForGig(gig: Gig) {
        if let index = liveGigs.firstIndex(where: { $0.id == gig.id }) {
            let appliedGig = liveGigs.remove(at: index)
            appliedGigs.append(appliedGig)
            gigHistory.applied += 1
            gigHistory.appliedGigs.append(appliedGig)
            objectWillChange.send()
        }
    }
    
    func withdrawGig(gigId: UUID) {
        if let index = appliedGigs.firstIndex(where: { $0.id == gigId }) {
            let withdrawnGig = appliedGigs.remove(at: index)
            gigHistory.applied -= 1
            gigHistory.appliedGigs.removeAll { $0.id == gigId }
            liveGigs.append(withdrawnGig) // Move back to live gigs
            objectWillChange.send()
        }
    }
}

// MARK: - Singleton Class to manage User and Gig data
class UserDataModel: ObservableObject {
    @Published private(set) var users: [User] = []
    static let shared = UserDataModel()
    
    @Published private var gigs: [Gig] = []
    
    private init() {
        let sampleGig1 = Gig(
            title: "Data Analyst", location: "Mumbai, India", jobType: "Contract", salary: "₹1000/hr", workMode: "Remote", timePosted: "3 hours ago", applicants: "50+ Applied", experienceRequired: "3 years +", workRole: "Analyst"
        )
        
        let sampleGig2 = Gig(
            title: "Frontend Developer", location: "Bangalore, India", jobType: "Full-time", salary: "₹1200/hr", workMode: "On-site", timePosted: "1 day ago", applicants: "30+ Applied", experienceRequired: "2 years +", workRole: "Web Developer"
        )
        
        let sampleGig3 = Gig(
            title: "Backend Developer", location: "Delhi, India", jobType: "Contract", salary: "₹1500/hr", workMode: "Remote", timePosted: "5 hours ago", applicants: "100+ Applied", experienceRequired: "4 years +", workRole: "Backend Engineer"
        )
        
        let userGigHistory = GigHistory()
        
        let sampleUser = User(
            id: UUID(),
            name: "Abhay Singh",
            gigHistory: userGigHistory,
            liveGigs: [sampleGig1, sampleGig2, sampleGig3], // All gigs start in liveGigs
            appliedGigs: [],
            postedGigs: []
        )
        
        users.append(sampleUser)
        gigs.append(contentsOf: [sampleGig1, sampleGig2, sampleGig3])
    }
    
    func getAllUsers() -> [User] {
        return users
    }
    
    func getUser(by id: UUID) -> User? {
        return users.first { $0.id == id }
    }
    
    func getLiveGigsNear(location: String) -> [Gig] {
        return gigs.filter { $0.location.lowercased() == location.lowercased() }
    }
    
    func getGigHistory(for userId: UUID) -> GigHistory? {
        return getUser(by: userId)?.gigHistory
    }
    
    func applyForGig(userId: UUID, gigId: UUID) {
        guard let userIndex = users.firstIndex(where: { $0.id == userId }) else { return }
        guard let gigIndex = users[userIndex].liveGigs.firstIndex(where: { $0.id == gigId }) else { return }
        
        // Move gig from liveGigs to appliedGigs
        let appliedGig = users[userIndex].liveGigs.remove(at: gigIndex)
        users[userIndex].appliedGigs.append(appliedGig)
        
        // Update gig history
        users[userIndex].gigHistory.applied += 1
        users[userIndex].gigHistory.appliedGigs.append(appliedGig)
        
        // Notify UI of changes
        objectWillChange.send()
    }
    
    func withdrawGig(userId: UUID, gigId: UUID) {
        if let userIndex = users.firstIndex(where: { $0.id == userId }) {
            if let gigIndex = users[userIndex].appliedGigs.firstIndex(where: { $0.id == gigId }) {
                let withdrawnGig = users[userIndex].appliedGigs.remove(at: gigIndex)
                users[userIndex].gigHistory.applied -= 1
                users[userIndex].gigHistory.appliedGigs.removeAll { $0.id == gigId }
                users[userIndex].liveGigs.append(withdrawnGig)
                objectWillChange.send()
            }
        }
    }
    
    func addGig(userId: UUID, gig: Gig) {
        if let userIndex = users.firstIndex(where: { $0.id == userId }) {
            users[userIndex].postedGigs.append(gig)
            users[userIndex].gigHistory.posted += 1
            objectWillChange.send()
        }
    }
    
    func editGig(userId: UUID, gigId: UUID, updatedGig: Gig) {
        if let userIndex = users.firstIndex(where: { $0.id == userId }),
           let gigIndex = users[userIndex].postedGigs.firstIndex(where: { $0.id == gigId }) {
            users[userIndex].postedGigs[gigIndex] = updatedGig
            objectWillChange.send()
        }
    }
    
    func deleteGig(userId: UUID, gigId: UUID) {
        if let userIndex = users.firstIndex(where: { $0.id == userId }) {
            users[userIndex].postedGigs.removeAll { $0.id == gigId }
            objectWillChange.send()
        }
    }
}

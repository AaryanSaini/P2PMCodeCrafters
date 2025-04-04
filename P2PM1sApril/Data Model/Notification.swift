import Foundation

// Structure to represent a Job Notification
struct Job: Identifiable {
    let id = UUID()
    let title: String
    let postedBy: String
    let location: String
    let pay: String
    let imageName: String
}

// Structure to represent a Connection Notification
struct Connection: Identifiable {
    let id = UUID()
    let name: String
    let connections: Int
    let location: String
    let role: String
    let imageName: String
}

// Data Model Class to manage notifications
class NotificationDataModel: ObservableObject {
    static let shared = NotificationDataModel()
    
    @Published var jobNotifications: [Job] = []
    @Published var connectionNotifications: [Connection] = []
    @Published var myConnections: [Connection] = [] // Stores accepted connections
    
    private init() {
        // Sample Data Initialization
        jobNotifications = [
            Job(title: "Full Stack Developer", postedBy: "Abhay", location: "Mohali", pay: "$35 per hr", imageName: "fs"),
            Job(title: "Java Developer", postedBy: "Aryan", location: "Zirakpur", pay: "$17 per hr", imageName: "java"),
            Job(title: "iOS Developer", postedBy: "Rahul", location: "Derabassi", pay: "$29 per hr", imageName: "ios")
        ]
        
        connectionNotifications = [
            Connection(name: "Abhay Singh", connections: 600, location: "Mohali", role: "iOS Developer", imageName: "person1"),
            Connection(name: "Aaryan Saini", connections: 1000, location: "Zirakpur", role: "MERN Developer", imageName: "person1"),
            Connection(name: "Rahul Choudhary", connections: 500, location: "Derabassi", role: "iOS Developer", imageName: "person1")
        ]
    }
    
    // Method to accept a job notification
    func acceptJobNotification(job: Job) {
        // Handle acceptance logic (e.g., save to a database, update user profile)
        print("Job accepted: \(job.title) posted by \(job.postedBy)")
        removeJobNotification(job: job)
    }
    
    // Method to accept a connection notification
    func acceptConnectionNotification(connection: Connection) {
        DispatchQueue.main.async {
            // Move connection to My Connections
            if !self.myConnections.contains(where: { $0.id == connection.id }) {
                self.myConnections.append(connection)
            }
            // Remove from pending connection notifications
            self.connectionNotifications.removeAll { $0.id == connection.id }
        }
    }

    // Method to remove a job notification
    func removeJobNotification(job: Job) {
        DispatchQueue.main.async {
            self.jobNotifications.removeAll { $0.id == job.id }
        }
    }

    // Method to remove a connection notification (Declined requests)
    func removeConnectionNotification(connection: Connection) {
        DispatchQueue.main.async {
            self.connectionNotifications.removeAll { $0.id == connection.id }
        }
    }
}

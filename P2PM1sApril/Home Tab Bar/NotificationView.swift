import SwiftUI

struct NotificationView: View {
    @State private var selectedTab = 0
    @ObservedObject var notificationDataModel = NotificationDataModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedTab) {
                    Text("Job Notifications").tag(0)
                    Text("Connection Notifications").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ScrollView {
                    VStack(spacing: 10) {
                        if selectedTab == 0 {
                            ForEach(notificationDataModel.jobNotifications) { job in
                                JobNotificationCard(job: job)
                            }
                        } else {
                            ForEach(notificationDataModel.connectionNotifications) { connection in
                                ConnectionNotificationCard(connection: connection)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Notifications", displayMode: .inline)
        }
    }
}

struct JobNotificationCard: View {
    let job: Job
    @State private var showAlert = false
    @State private var showDeclineAlert = false
    
    var body: some View {
        HStack {
            Image(job.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                
            VStack(alignment: .leading, spacing: 5) {
                Text(job.title)
                    .font(.headline)
                    .bold()
                Text("📍 Location : \(job.location)")
                Text("💰 \(job.pay)")
                
                HStack {
                    Button(action: {
                        NotificationDataModel.shared.acceptJobNotification(job: job)
                        showAlert = true
                    }) {
                        Text("Apply")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 85, height: 38)
                            .background(Color(hex: "262860"))
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Success"), message: Text("Job added successfully!"), dismissButton: .default(Text("OK"), action: {
                            NotificationDataModel.shared.removeJobNotification(job: job)
                        }))
                    }
                    
                    Button(action: {
                        showDeclineAlert = true
                    }) {
                        Text("Decline")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 85, height: 38)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showDeclineAlert) {
                        Alert(title: Text("Declined"), message: Text("Job declined successfully!"), dismissButton: .default(Text("OK"), action: {
                            NotificationDataModel.shared.removeJobNotification(job: job)
                        }))
                    }
                }
                .padding(.top, 5)
            }
            .padding()
        }
        .frame(width: 365, height: 169)
        .background(Color(hex: "F4F4F7"))
        .cornerRadius(15)
    }
}

struct ConnectionNotificationCard: View {
    let connection: Connection
    @State private var showAlert = false
    @State private var showDeclineAlert = false
    @State private var pendingConnection: Connection?

    var body: some View {
        HStack {
            Image(connection.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {
                Text(connection.name)
                    .font(.headline)
                    .bold()
                Text("➕ Connections : \(connection.connections)")
                Text("📍 Location : \(connection.location)")
                Text("💼 \(connection.role)")

                HStack {
                    Button(action: {
                        pendingConnection = connection
                        showAlert = true
                    }) {
                        Text("Accept")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 85, height: 38)
                            .background(Color(hex: "262860"))
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Confirm"),
                            message: Text("Do you want to accept \(connection.name)?"),
                            primaryButton: .default(Text("Yes"), action: {
                                if let conn = pendingConnection {
                                    NotificationDataModel.shared.acceptConnectionNotification(connection: conn)
                                    NotificationDataModel.shared.removeConnectionNotification(connection: conn)
                                }
                            }),
                            secondaryButton: .cancel(Text("No"))
                        )
                    }

                    Button(action: {
                        pendingConnection = connection
                        showDeclineAlert = true
                    }) {
                        Text("Decline")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 85, height: 38)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showDeclineAlert) {
                        Alert(
                            title: Text("Confirm"),
                            message: Text("Do you want to decline \(connection.name)?"),
                            primaryButton: .default(Text("Yes"), action: {
                                if let conn = pendingConnection {
                                    NotificationDataModel.shared.removeConnectionNotification(connection: conn)
                                }
                            }),
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
                }
                .padding(.top, 5)
            }
            .padding()
        }
        .frame(width: 365, height: 169)
        .background(Color(hex: "F4F4F7"))
        .cornerRadius(15)
    }
}

struct Notification_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

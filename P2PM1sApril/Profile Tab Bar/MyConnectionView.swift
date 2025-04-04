import SwiftUI

struct MyConnectionView: View {
    @ObservedObject var notificationDataModel = NotificationDataModel.shared
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                // Section for Total Connection Count
                Section(header: Text("Total Connections: \(notificationDataModel.myConnections.count)")
                    .font(.headline)
                    .foregroundColor(.black)
                ) {
                    if notificationDataModel.myConnections.isEmpty {
                        Text("No connections yet.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(notificationDataModel.myConnections) { connection in
                            HStack {
                                Image(connection.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(connection.name)
                                        .font(.headline)
                                    Text("📍 \(connection.location)")
                                    Text("💼 \(connection.role)")
                                }
                            }
                            .padding(.vertical, 5)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteConnection(connection)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                        }
                        .onDelete(perform: deleteMultipleConnections) // For edit mode deletion
                    }
                }
            }
            .listStyle(InsetGroupedListStyle()) // Modern iOS look
            .navigationTitle("My Connections")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                }
            }
            .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        }
    }
    
    // Function to delete a single connection using swipe
    private func deleteConnection(_ connection: Connection) {
        if let index = notificationDataModel.myConnections.firstIndex(where: { $0.id == connection.id }) {
            notificationDataModel.myConnections.remove(at: index)
        }
    }
    
    // Function to delete multiple connections in edit mode
    private func deleteMultipleConnections(at offsets: IndexSet) {
        notificationDataModel.myConnections.remove(atOffsets: offsets)
    }
}

import SwiftUI


struct BookingView: View {
    let workspaceName: String
    
    @State private var selectedDate = Date()
    @State private var numberOfPersons = 1
    @State private var startTime = Date()
    @State private var endTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    @State private var showAlert = false
    @AppStorage("bookings") private var bookingsData: Data = Data()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workspace")) {
                    Text(workspaceName)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Section(header: Text("Select Date")) {
                    HStack {
                        DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
                }
                
                Section(header: Text("Number of Persons")) {
                    Stepper("\(numberOfPersons)", value: $numberOfPersons, in: 1...10)
                }
                
                Section(header: Text("Time Selection")) {
                    HStack {
                        Text("Start Time")
                        Spacer()
                        DatePicker("", selection: $startTime, in: Date()..., displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("End Time")
                        Spacer()
                        DatePicker("", selection: $endTime, in: Calendar.current.date(byAdding: .hour, value: 1, to: startTime)!..., displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                
                Section {
                    Button(action: saveBooking) {
                        Text("Book now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Workspace Booked"), message: Text("Your booking details are under Booking Notification."), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .navigationTitle("Booking")
        }
    }
    
    private func saveBooking() {
        let newBooking = Booking(workspaceName: workspaceName, selectedDate: selectedDate, numberOfPersons: numberOfPersons, startTime: startTime, endTime: endTime)
        var bookings = loadBookings()
        bookings.append(newBooking)
        if let encoded = try? JSONEncoder().encode(bookings) {
            bookingsData = encoded
        }
        showAlert = true
    }
    
    private func loadBookings() -> [Booking] {
        if let decoded = try? JSONDecoder().decode([Booking].self, from: bookingsData) {
            return decoded
        }
        return []
    }
}

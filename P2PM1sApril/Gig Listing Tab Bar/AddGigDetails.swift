import SwiftUI

struct AddGigDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var salary: String = ""
    @State private var jobType: String = "Full Time"
    @State private var workMode: String = "On-site"
    @State private var experienceRequired: String = ""
    @State private var workRole: String = ""
    
    @State private var showSalaryAlert = false
    @State private var showExperienceAlert = false
    
    let jobTypes = ["Full Time", "Part Time", "Freelance", "Contract"]
    let workModes = ["Remote", "On-site", "Hybrid"]
    
    var onSave: (Gig) -> Void
    
    var allFieldsFilled: Bool {
        !title.isEmpty &&
        !location.isEmpty &&
        !salary.isEmpty &&
        !experienceRequired.isEmpty &&
        !workRole.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title*", text: $title)
                    TextField("Location*", text: $location)
                    
                    TextField("Salary (e.g. ₹900/hr)*", text: $salary)
                        .keyboardType(.numberPad)
                        .onChange(of: salary) { newValue in
                            if newValue.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                                showSalaryAlert = true
                                salary = newValue.filter { "0123456789".contains($0) }
                            }
                        }
                    
                    Picker("Job Type*", selection: $jobType) {
                        ForEach(jobTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    
                    Picker("Work Mode*", selection: $workMode) {
                        ForEach(workModes, id: \.self) { mode in
                            Text(mode)
                        }
                    }
                    
                    TextField("Experience Required (e.g. 3 years)*", text: $experienceRequired)
                        .keyboardType(.numberPad)
                        .onChange(of: experienceRequired) { newValue in
                            if newValue.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                                showExperienceAlert = true
                                experienceRequired = newValue.filter { "0123456789".contains($0) }
                            }
                        }
                    
                    TextField("Work Role (e.g. Developer, Designer)*", text: $workRole)
                }
                
                Section {
                    Button(action: saveGig) {
                        Text("Save Gig")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(allFieldsFilled ? Color(hex: "262860") : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!allFieldsFilled)
                }
            }
            .navigationTitle("Add Gig")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert("Numbers Only", isPresented: $showSalaryAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please enter numbers only for salary field")
            }
            .alert("Numbers Only", isPresented: $showExperienceAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please enter numbers only for experience field")
            }
        }
    }
    
    func saveGig() {
        guard let user = UserDataModel.shared.getAllUsers().first else { return }
        
        let newGig = Gig(
            id: UUID(),
            title: title,
            location: location,
            jobType: jobType,
            salary: salary,
            workMode: workMode,
            timePosted: formatTime(from: Date()),
            applicants: "0 Applied",
            experienceRequired: experienceRequired,
            workRole: workRole
        )

        UserDataModel.shared.addGig(userId: user.id, gig: newGig)
        presentationMode.wrappedValue.dismiss()
    }
    
    func formatTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
}

// MARK: - Color Extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct AddGigDetails_Previews: PreviewProvider {
    static var previews: some View {
        AddGigDetails { _ in }
    }
}

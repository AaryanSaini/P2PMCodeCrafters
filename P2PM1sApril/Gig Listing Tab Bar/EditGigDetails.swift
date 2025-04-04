//
//  EditGigDetails.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//


import SwiftUI

struct EditGigDetails: View {
    @Environment(\.presentationMode) var presentationMode
    
    var gig: Gig
    var onSave: (Gig) -> Void
    
    @State private var title: String
    @State private var location: String
    @State private var salary: String
    @State private var jobType: String
    @State private var workMode: String
    @State private var applicants: String
    @State private var experienceRequired: String
    @State private var workRole: String

    let jobTypes = ["Full Time", "Part Time", "Freelance", "Contract"]
    let workModes = ["Remote", "On-site", "Hybrid"]
    
    init(gig: Gig, onSave: @escaping (Gig) -> Void) {
        self.gig = gig
        self.onSave = onSave
        _title = State(initialValue: gig.title)
        _location = State(initialValue: gig.location)
        _salary = State(initialValue: gig.salary)
        _jobType = State(initialValue: gig.jobType)
        _workMode = State(initialValue: gig.workMode)
        _applicants = State(initialValue: gig.applicants)
        _experienceRequired = State(initialValue: gig.experienceRequired)
        _workRole = State(initialValue: gig.workRole)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title", text: $title)
                    TextField("Location", text: $location)
                    TextField("Salary (e.g. ₹900/hr)", text: $salary)
                        .keyboardType(.numberPad)
                    Picker("Job Type", selection: $jobType) {
                        ForEach(jobTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    Picker("Work Mode", selection: $workMode) {
                        ForEach(workModes, id: \.self) { mode in
                            Text(mode)
                        }
                    }
                    TextField("Experience Required (e.g. 3 years +)", text: $experienceRequired)
                    TextField("Work Role", text: $workRole)
                }
                
                Section(header: Text("Applicants")) {
                    TextField("Applicants", text: $applicants)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: saveChanges) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "262860"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Edit Gig")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    func saveChanges() {
        let updatedGig = Gig(
            id: gig.id,
            title: title,
            location: location,
            jobType: jobType,
            salary: salary,
            workMode: workMode,
            timePosted: gig.timePosted, // Keep the original time
            applicants: applicants,
            experienceRequired: experienceRequired,
            workRole: workRole
        )

        onSave(updatedGig)
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Preview
struct EditGigDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditGigDetails(gig: Gig(id: UUID(), title: "Sample", location: "Mumbai", jobType: "Full Time", salary: "₹1000/hr", workMode: "Remote", timePosted: "Just now", applicants: "10+ Applied", experienceRequired: "3 years", workRole: "Developer")) { _ in }
    }
}

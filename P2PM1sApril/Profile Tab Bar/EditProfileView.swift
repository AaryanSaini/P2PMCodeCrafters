//
//  EditProfileView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import SwiftUI

// Edit Profile Screen
struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String
    @State private var role: String
    @State private var email: String
    @State private var phone: String

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        _name = State(initialValue: viewModel.profile.name)
        _role = State(initialValue: viewModel.profile.role)
        _email = State(initialValue: viewModel.profile.email)
        _phone = State(initialValue: viewModel.profile.phone)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Profile")) {
                    TextField("Name", text: $name)
                    TextField("Role", text: $role)
                }

                Section(header: Text("Contact Information")) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        saveChanges()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .bold()
                }
            }
        }
    }

    private func saveChanges() {
        viewModel.profile.name = name
        viewModel.profile.role = role
        viewModel.profile.email = email
        viewModel.profile.phone = phone
    }
}

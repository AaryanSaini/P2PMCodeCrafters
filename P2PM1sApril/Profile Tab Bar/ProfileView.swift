import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isImagePickerPresented = false
    @State private var isCamera = false
    @State private var showActionSheet = false
    @State private var showLogoutConfirmation = false

    var body: some View {
        NavigationView {
            VStack {
                // Profile Image
                VStack {
                    if let image = viewModel.profile.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .onTapGesture {
                                showActionSheet = true
                            }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                showActionSheet = true
                            }
                    }
                }
                .padding(.vertical, 10)

                Text(viewModel.profile.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(viewModel.profile.role)
                    .font(.headline)
                    .foregroundColor(.gray)

                List {
                    Section(header: Text("Settings")) {
                        NavigationLink(destination: PersonalInformationView(viewModel: viewModel)) {
                            Text("Personal Information")
                        }
                        NavigationLink(destination: AboutView()) {
                            Text("About")
                        }
                        NavigationLink(destination: MyConnectionView()) {
                            Text("My Connections")
                        }
                        NavigationLink(destination: BookmarkView()) {
                            Text("Bookmarked Gigs")
                        }
                        NavigationLink(destination: BookingsView()) {
                            Text("Bookings")
                        }
                    }

                    // Log Out Section
                    Section {
                        Button(role: .destructive) {
                            showLogoutConfirmation = true
                        } label: {
                            HStack {
                                Spacer()
                                Text("Log Out")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Profile")
            .confirmationDialog("Select Image Source", isPresented: $showActionSheet, titleVisibility: .visible) {
                Button("Take Photo") {
                    isCamera = true
                    isImagePickerPresented = true
                }
                Button("Choose from Library") {
                    isCamera = false
                    isImagePickerPresented = true
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $viewModel.profile.image, sourceType: isCamera ? .camera : .photoLibrary)
            }

            .alert("Are you sure you want to log out?", isPresented: $showLogoutConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) {
                    logout()
                }
            }
        }
    }

    // Logout Function
    private func logout() {
        print("User logged out")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

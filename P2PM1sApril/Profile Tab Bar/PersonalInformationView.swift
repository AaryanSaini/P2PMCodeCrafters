import SwiftUI

struct PersonalInformationView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var isImagePickerPresented = false
    @State private var isEditProfilePresented = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false  // Added Action Sheet state

    var body: some View {
        VStack {
            Spacer()

            // Profile Image Section
            VStack {
                if let image = viewModel.profile.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .onTapGesture {
                            showActionSheet = true  // Show action sheet on tap
                        }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            showActionSheet = true  // Show action sheet on tap
                        }
                }
            }
            .padding(.bottom, 20)

            // Edit Button
            Button("Edit") {
                isEditProfilePresented = true
            }
            .foregroundColor(.blue)

            // Profile Information Form (Read-Only)
            Form {
                Section(header: Text("Basic Info")) {
                    HStack {
                        Text("Full Name")
                        Spacer()
                        Text(viewModel.profile.name)
                    }
                    HStack {
                        Text("Role")
                        Spacer()
                        Text(viewModel.profile.role)
                    }
                }

                Section(header: Text("Contact Info")) {
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(viewModel.profile.email)
                    }
                    HStack {
                        Text("Phone")
                        Spacer()
                        Text(viewModel.profile.phone)
                    }
                }
            }
        }
        .navigationBarTitle("Personal Information", displayMode: .inline)
        .sheet(isPresented: $isEditProfilePresented) {
            EditProfileView(viewModel: viewModel)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.profile.image, sourceType: selectedSourceType) // Pass sourceType
        }
        .actionSheet(isPresented: $showActionSheet) {  // Show action sheet for selecting source type
            ActionSheet(
                title: Text("Select Image Source"),
                message: Text("Choose how you want to select an image."),
                buttons: [
                    .default(Text("Choose from Photos")) {
                        selectedSourceType = .photoLibrary
                        isImagePickerPresented = true
                    },
                    .default(Text("Take a Photo")) {
                        selectedSourceType = .camera
                        isImagePickerPresented = true
                    },
                    .cancel()
                ]
            )
        }
    }
}

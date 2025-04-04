import SwiftUI

struct MarketProfileDetailView: View {
    let profile: MarketProfile

    var body: some View {
        ScrollView {
            VStack(spacing: 20) { // Added spacing between all sections
                
                // Profile Image
                Image(profile.profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.top, 10)

                // Name & Specialization
                VStack(spacing: 8) {
                    Text(profile.name)
                        .font(.title2)
                        .bold()

                    Text("\(profile.specialization), \(profile.location)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Stats Section
                HStack(spacing: 40) {
                    VStack {
                        Text("\(profile.connections)")
                            .font(.title3)
                            .bold()
                        Text("Connections")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }

                    VStack {
                        Text("\(profile.jobsPosted)")
                            .font(.title3)
                            .bold()
                        Text("Job Posted")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }

                    VStack {
                        Text("\(profile.jobsApplied)")
                            .font(.title3)
                            .bold()
                        Text("Job Applied")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .padding(.top, 10)

                // Buttons Section
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Text("Connect")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {}) {
                        Text("Message")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)

                // Active Projects Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Active Projects")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 16)

                    List(profile.activeProjects) { project in
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                            
                            VStack(alignment: .leading) {
                                Text(project.name)
                                    .font(.headline)
                                Text(project.startDate)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: 200)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Details Market Profile") // Set navigation bar title
        .navigationBarTitleDisplayMode(.inline) // Inline style for a clean look
    }
}

struct MarketProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for preview
            MarketProfileDetailView(profile: MarketProfileManager.shared.profiles[0])
        }
    }
}

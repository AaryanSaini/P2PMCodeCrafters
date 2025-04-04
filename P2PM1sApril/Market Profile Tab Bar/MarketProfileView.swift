import SwiftUI

struct MarketProfileView: View {
    @State private var searchText = ""
    private let profiles = MarketProfileManager.shared.profiles

    var filteredProfiles: [MarketProfile] {
        if searchText.isEmpty {
            return profiles
        } else {
            return profiles.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
//                // Market Profile Title
//                Text("Market Profile")
//                    .font(.largeTitle)
//                    .bold()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading)

                // Search Bar
                TextField("Search Profile", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Profile Grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(filteredProfiles) { profile in
                            VStack {
                                // Profile Image
                                Image(profile.profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())

                                // Profile Info
                                Text(profile.name)
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Text(profile.specialization)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Text(profile.location)
                                    .font(.caption)
                                    .foregroundColor(.gray)

                                // Visit Profile Button
                                NavigationLink(destination: MarketProfileDetailView(profile: profile)) {
                                    Text("Visit Profile")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 140)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            }
                            .frame(width: 160, height: 220)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Market Profile", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: MessageView()) {
                    Image(systemName: "message.fill")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            )
        }
    }
}

struct MarketProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MarketProfileView()
    }
}

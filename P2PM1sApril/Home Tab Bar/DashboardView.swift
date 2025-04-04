import SwiftUI

// MARK: - Dashboard View
struct DashboardView: View {
    
    // Fetching user data from the shared UserDataModel
    @State private var user: User = UserDataModel.shared.getAllUsers().first!
    @State private var currentGigIndex = 0
    @State private var isBookmarked = false
    @State private var offset: CGFloat = 0  // For animation
    @State private var bookmarkedGigs: Set<UUID> = [] // To track bookmarked gigs
    @State private var showApplyAlert = false
    @State private var selectedGig: Gig?  // Holds the gig user is applying for
    @ObservedObject var bookmarkModel = BookmarkedGigsModel.shared
    @ObservedObject var userDataModel = UserDataModel.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Header
                ZStack(alignment: .topLeading) {
                    LinearGradient(gradient: Gradient(colors: [
                        Color(hex: "3A3C92"),
                        Color(hex: "262860"),
                        Color(hex: "11122C")
                    ]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 284)
                    .ignoresSafeArea(.all, edges: .top)

                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Hello")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text(user.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            NavigationLink(destination: NotificationView()) {
                                Image(systemName: "bell.badge.fill")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                        .padding(.top, 50)
                        .padding(.horizontal)
                        
                        Text("Let’s find a perfect opportunity for you")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(.horizontal)
                    }
                }
                
                // Gig History Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Gig History")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color(hex: "262860"))

                    HStack(spacing: 15) {
                        NavigationLink(destination: GigHistoryHome(title: "Gig Applied", gigs: user.gigHistory.appliedGigs)) {
                            gigHistoryBox(number: "\(user.gigHistory.applied)", label: "Gig Applied")
                        }

                        NavigationLink(destination: GigHistoryHome(title: "Gig Posted", gigs: userDataModel.users.first?.gigHistory.postedGigs ?? [])) {
                            gigHistoryBox(number: "\(userDataModel.users.first?.postedGigs.count ?? 0)", label: "Gig Posted")
                        }

                    }
                }
                .padding(.horizontal)
                .padding(.top, -40)

                // Live Gigs Section with Animation
                VStack(alignment: .leading, spacing: 10) {
                    Text("Live Gigs Near you")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color(hex: "262860"))

                    ZStack {
                        ForEach(user.liveGigs.indices, id: \.self) { index in
                            if index == currentGigIndex {
                                gigCard(gig: user.liveGigs[index], isBookmarked: bookmarkedGigs.contains(user.liveGigs[index].id))
                                    .offset(x: offset)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.8))
                            }
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation.width
                            }
                            .onEnded { value in
                                if value.translation.width < -100 && currentGigIndex < user.liveGigs.count - 1 {
                                    withAnimation {
                                        currentGigIndex += 1
                                    }
                                } else if value.translation.width > 100 && currentGigIndex > 0 {
                                    withAnimation {
                                        currentGigIndex -= 1
                                    }
                                }
                                offset = 0
                            }
                    )
                    
                    // Page Control - Centered Below Gig Card
                    HStack {
                        ForEach(0..<user.liveGigs.count, id: \.self) { index in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(currentGigIndex == index ? Color(hex: "262860") : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        currentGigIndex = index
                                    }
                                }
                        }
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .padding(.top, 35)

                Spacer()
            }
        }
        .alert(isPresented: $showApplyAlert) {
            Alert(
                title: Text("Apply for Gig"),
                message: Text("Are you sure you want to apply for \(selectedGig?.title ?? "")?"),
                primaryButton: .default(Text("Yes"), action: {
                    applyForGig()
                }),
                secondaryButton: .cancel()
            )
        }
    }
    
    // MARK: - Gig History Box
    func gigHistoryBox(number: String, label: String) -> some View {
        VStack {
            Text(number)
                .font(.system(size: 96, weight: .medium))
                .foregroundColor(Color(hex: "262860"))
            Text(label)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.gray)
        }
        .frame(width: 170, height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    // MARK: - Gig Card
    // MARK: - Gig Card
    func gigCard(gig: Gig, isBookmarked: Bool) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                gigTag(text: gig.jobType)
                gigTag(text: gig.salary)
                Spacer()
                
                // Bookmark Button
                Button(action: {
                    toggleBookmark(gig: gig)
                }) {
                    Image(systemName: bookmarkModel.isBookmarked(gig: gig) ? "bookmark.fill" : "bookmark")
                        .foregroundColor(bookmarkModel.isBookmarked(gig: gig) ? Color(hex: "262860") : .gray)
                        .font(.title2)
                }

            }

            Text(gig.title)
                .font(.headline)
                .foregroundColor(Color(hex: "262860"))

            Text(gig.location)
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                Text(gig.timePosted)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text(gig.applicants)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Button(action: {
                selectedGig = gig
                showApplyAlert = true
            }) {
                Text("Apply")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "262860"))
                    .cornerRadius(8)
            }

        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }


    // MARK: - Apply for Gig
    func applyForGig() {
        guard let gig = selectedGig else { return }
        user.applyForGig(gig: gig)
        user.gigHistory.applied += 0
        user.gigHistory.appliedGigs.append(gig)
        user.liveGigs.removeAll { $0.id == gig.id }
        
        // Move to the next gig after applying
        if currentGigIndex >= user.liveGigs.count {
               currentGigIndex = max(0, user.liveGigs.count - 1)
           }

//        objectWillChange.send()
    }

    // MARK: - Toggle Bookmark
    func toggleBookmark(gig: Gig) {
        bookmarkModel.toggleBookmark(gig: gig)
    }

    // MARK: - Gig Tag View
    func gigTag(text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(Color(hex: "262860"))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(hex: "EDEDF7"))
            .cornerRadius(12)
    }
}


// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
// MARK: - Gig List View


//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.currentIndex = scanner.string.startIndex
//        var rgb: UInt64 = 0
//        scanner.scanHexInt64(&rgb)
//        self.init(
//            .sRGB,
//            red: Double((rgb & 0xFF0000) >> 16) / 255,
//            green: Double((rgb & 0x00FF00) >> 8) / 255,
//            blue: Double(rgb & 0x0000FF) / 255,
//            opacity: 1
//        )
//    }
//}



import SwiftUI

struct GigListView: View {
    @State private var selectedSegment = "Live"
    @State private var searchQuery = ""
    @State private var showApplyAlert = false
    @State private var showWithdrawAlert = false
    @State private var selectedGigToWithdraw: Gig?
    @State private var showDeleteAlert = false
    @State private var selectedGigToDelete: Gig?
    @State private var selectedGig: Gig?
    @State private var showAddGigView = false
    @State private var showEditGigView = false
    @State private var gigToEditIndex: Int?
    
    @StateObject var userDataModel = UserDataModel.shared
    
    var user: User? { userDataModel.getAllUsers().first }
    var filteredGigs: [Gig] {
        let gigs = getCurrentGigs()
        return gigs.filter { gig in
            searchQuery.isEmpty ||
            gig.title.localizedCaseInsensitiveContains(searchQuery) ||
            gig.location.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Picker("Segments", selection: $selectedSegment) {
                    Text("Live").tag("Live")
                    Text("Applied").tag("Applied")
                    Text("Posted").tag("Posted")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .accessibilityLabel("Segment Picker")
                
                TextField("Search by title or location", text: $searchQuery)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredGigs, id: \.id) { gig in
                            gigCard(gig: gig)
                                .transition(.asymmetric(
                                    insertion: .opacity,
                                    removal: .slide.combined(with: .opacity)
                                ))
                        }
                    }
                    .padding(.horizontal)
                    .animation(.easeInOut(duration: 0.3), value: filteredGigs)
                }
            }
            .navigationTitle("Gig List")
            .navigationBarItems(trailing: Button(action: {
                showAddGigView = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(Color(hex: "262860"))
            })
            .sheet(isPresented: $showAddGigView) {
                AddGigDetails { newGig in
                    if let user = user {
                        userDataModel.addGig(userId: user.id, gig: newGig)
                    }
                }
            }
            .sheet(isPresented: $showEditGigView) {
                if let user = user, let gig = selectedGig {
                    EditGigDetails(gig: gig) { updatedGig in
                        userDataModel.editGig(userId: user.id, gigId: gig.id, updatedGig: updatedGig)
                    }
                }
            }
            .alert("Confirm Apply", isPresented: $showApplyAlert, presenting: selectedGig) { gig in
                Button("Yes") {
                    applyForGig(gig)
                }
                Button("Cancel", role: .cancel) {}
            } message: { gig in
                Text("Are you sure you want to apply for '\(gig.title)'?")
            }
            .alert("Confirm Withdraw", isPresented: $showWithdrawAlert, presenting: selectedGigToWithdraw) { gig in
                Button("Yes") {
                    withdrawGig(gig)
                }
                Button("Cancel", role: .cancel) {}
            } message: { gig in
                Text("Are you sure you want to withdraw your application for '\(gig.title)'?")
            }
            .alert(item: $selectedGigToDelete) { gig in
                Alert(
                    title: Text("Delete Gig"),
                    message: Text("Are you sure you want to delete '\(gig.title)'?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteGig(gigId: gig.id)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    func getCurrentGigs() -> [Gig] {
        guard let user = user else { return [] }
        
        switch selectedSegment {
        case "Live":
            return user.liveGigs.filter { liveGig in
                !user.appliedGigs.contains(where: { $0.id == liveGig.id })
            }
        case "Applied":
            return user.appliedGigs
        case "Posted":
            return user.postedGigs
        default:
            return []
        }
    }

    func gigCard(gig: Gig) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                gigTag(text: gig.jobType)
                gigTag(text: gig.salary)
                gigTag(text: gig.workMode)
                Spacer()
                
                if selectedSegment == "Posted" {
                    Button(action: {
                        selectedGig = gig
                        showEditGigView = true
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                            .padding(8)
                    }
                    Button(action: {
                        selectedGigToDelete = gig
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding(8)
                    }
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
            
            Group {
                if selectedSegment == "Posted" {
                    Text("Posted")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else if selectedSegment == "Applied" {
                    HStack {
                        Text("Applied")
                            .font(.headline)
                            .foregroundColor(Color(hex: "262860"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "262860").opacity(0.1))
                            .cornerRadius(8)
                        
                        Button(action: {
                            selectedGigToWithdraw = gig
                            showWithdrawAlert = true
                        }) {
                            Text("Withdraw")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                } else { // Live segment
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
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    func gigTag(text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(Color(hex: "262860"))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(hex: "EDEDF7"))
            .cornerRadius(12)
    }
    
    func applyForGig(_ gig: Gig) {
        guard let user = user else { return }
        userDataModel.applyForGig(userId: user.id, gigId: gig.id)
        selectedGig = nil
    }
    
    func withdrawGig(_ gig: Gig) {
        guard let user = user else { return }
        userDataModel.withdrawGig(userId: user.id, gigId: gig.id)
        selectedGigToWithdraw = nil
    }
    
    func deleteGig(gigId: UUID) {
        guard let user = user else { return }
        userDataModel.deleteGig(userId: user.id, gigId: gigId)
    }
}

struct GigListView_Previews: PreviewProvider {
    static var previews: some View {
        GigListView()
    }
}

import SwiftUI
import MapKit

struct MapView: View {
    let workspaces: [Workspace]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946), // Default location (Bangalore)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var selectedState = "Karnataka"
    @State private var searchQuery = ""
    @State private var searchResults: [Workspace] = []
    @State private var selectedWorkspace: Workspace?
    
    let statesAndUTs = [
        "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal", "Andaman and Nicobar Islands", "Chandigarh", "Dadra and Nagar Haveli and Daman and Diu", "Lakshadweep", "Delhi", "Puducherry", "Ladakh", "Jammu and Kashmir"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search for a workspace", text: $searchQuery)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: searchQuery) { newValue in
                            searchWorkspaces(query: newValue)
                        }

                    Spacer()

                    Menu {
                        ForEach(statesAndUTs, id: \ .self) { state in
                            Button(state) {
                                selectedState = state
                                updateRegionForState(state)
                            }
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.down.circle.fill")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                }
                .padding()

                Map(coordinateRegion: $region, annotationItems: searchResults.isEmpty ? workspaces : searchResults) { workspace in
                    MapAnnotation(coordinate: workspace.coordinate) {
                        VStack {
                            Button(action: {
                                selectedWorkspace = workspace
                            }) {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                            }
                            
                            VStack(spacing: 2) {
                                Text(workspace.name)
                                    .font(.caption)
                                    .bold()
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                if let gigsOpen = workspace.gigsOpen {
                                    Button(action: {
                                        selectedWorkspace = workspace
                                    }) {
                                        Text(gigsOpen)
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                            .background(Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                }
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .sheet(item: $selectedWorkspace) { workspace in
                    GigListView1(workspace: workspace)
                }
            }
            .navigationTitle("Workspaces")
        }
    }
    
    func searchWorkspaces(query: String) {
        if query.isEmpty {
            searchResults = []
        } else {
            searchResults = workspaces.filter { workspace in
                workspace.name.lowercased().contains(query.lowercased()) || workspace.distance.lowercased().contains(query.lowercased())
            }
        }
    }
    
    func updateRegionForState(_ state: String) {
        let stateCoordinates: [String: CLLocationCoordinate2D] = [
            "Andhra Pradesh": CLLocationCoordinate2D(latitude: 15.9129, longitude: 79.7400),
            "Arunachal Pradesh": CLLocationCoordinate2D(latitude: 28.2180, longitude: 94.7278),
            "Assam": CLLocationCoordinate2D(latitude: 26.2006, longitude: 92.9376),
            "Bihar": CLLocationCoordinate2D(latitude: 25.0961, longitude: 85.3131),
            "Chhattisgarh": CLLocationCoordinate2D(latitude: 21.2787, longitude: 81.8661),
            "Goa": CLLocationCoordinate2D(latitude: 15.2993, longitude: 74.1240),
            "Gujarat": CLLocationCoordinate2D(latitude: 22.2587, longitude: 71.1924),
            "Haryana": CLLocationCoordinate2D(latitude: 29.0588, longitude: 76.0856),
            "Himachal Pradesh": CLLocationCoordinate2D(latitude: 31.1048, longitude: 77.1734),
            "Jharkhand": CLLocationCoordinate2D(latitude: 23.6102, longitude: 85.2799),
            "Karnataka": CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
            "Kerala": CLLocationCoordinate2D(latitude: 10.8505, longitude: 76.2711),
            "Madhya Pradesh": CLLocationCoordinate2D(latitude: 23.2599, longitude: 77.4126),
            "Maharashtra": CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777),
            "Manipur": CLLocationCoordinate2D(latitude: 24.6637, longitude: 93.9063),
            "Meghalaya": CLLocationCoordinate2D(latitude: 25.4670, longitude: 91.3662),
            "Mizoram": CLLocationCoordinate2D(latitude: 23.1645, longitude: 92.9376),
            "Nagaland": CLLocationCoordinate2D(latitude: 26.1584, longitude: 94.5624),
            "Odisha": CLLocationCoordinate2D(latitude: 20.9517, longitude: 85.0985),
            "Punjab": CLLocationCoordinate2D(latitude: 31.1471, longitude: 75.3412),
            "Rajasthan": CLLocationCoordinate2D(latitude: 27.0238, longitude: 74.2179),
            "Sikkim": CLLocationCoordinate2D(latitude: 27.5330, longitude: 88.5122),
            "Tamil Nadu": CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707),
            "Telangana": CLLocationCoordinate2D(latitude: 17.3850, longitude: 78.4867),
            "Uttar Pradesh": CLLocationCoordinate2D(latitude: 26.8467, longitude: 80.9462),
            "Uttarakhand": CLLocationCoordinate2D(latitude: 30.0668, longitude: 79.0193),
            "West Bengal": CLLocationCoordinate2D(latitude: 22.9868, longitude: 87.8550)
        ]
        if let newCenter = stateCoordinates[state] {
            region.center = newCenter
        }
    }
}


struct GigListView1: View {
    let workspace: Workspace
    
    var body: some View {
        NavigationView {
            List {
                if let gigs = workspace.gigsOpen {
                    Text("Available Gigs: " + gigs)
                } else {
                    Text("No gigs available")
                }
            }
            .navigationTitle(workspace.name)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(workspaces: WorkspaceManager.shared.getWorkspaces())
    }
}

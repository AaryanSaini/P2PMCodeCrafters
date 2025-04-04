import SwiftUI

struct ContentView: View {
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarColor")
//    }
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MarketProfileView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Market Profile")
                }
            
            GigListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Gig Listing")
                }
            
            WorkspaceView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("iCo-work")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .accentColor(.blue) // Set selected tab item color
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

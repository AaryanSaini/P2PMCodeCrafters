//  WorkspaceView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 01/04/25.
//

import SwiftUI
import MapKit

struct WorkspaceView: View {
    let workspaces = WorkspaceManager.shared.getWorkspaces()
    
    @State private var selectedLocation: String = "Current Location"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Location Selector
                HStack {
                    Text(selectedLocation)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.blue)

                    NavigationLink(destination: MapView(workspaces: workspaces)) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Text("Change")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal, 16)
                
                // Title
                Text("WorkSpace Near You")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.leading, 16)
                
                // Horizontal Scroll for Workspaces
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(workspaces) { workspace in
                            NavigationLink(destination: WorkspaceDetailView(workspace: workspace)) {
                                WorkspaceCard(workspace: workspace)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
            .navigationTitle("iCo-Work")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: BookingHistoryView()) {
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: "262860"))
                    }
            )
        }
    }
}

// Preview
struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
    }
}

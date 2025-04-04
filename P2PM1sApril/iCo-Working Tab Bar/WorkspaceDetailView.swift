//
//  WorkspaceDetailView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import SwiftUI

// Workspace Detail View
struct WorkspaceDetailView: View {
    let workspace: Workspace
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(workspace.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(workspace.name)
                .font(.title2).bold()
                .foregroundColor(Color(hex: "262860"))
                .padding(.bottom, 2)
            
            Text(workspace.distance)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(workspace.features, id: \ .self) { feature in
                    Text(feature)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 10)
            
            if let gigsOpen = workspace.gigsOpen {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Today Gigs at Work:")
                        .font(.headline)
                        .foregroundColor(Color(hex: "262860"))
                    Text(gigsOpen)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(hex: "262860"))
                        .cornerRadius(8)
                }
                .padding(.bottom, 10)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Offers at this Workspace")
                    .font(.headline)
                    .foregroundColor(Color(hex: "262860"))
                
                Text(workspace.offer)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(8)
                    .background(Color(hex: "262860").opacity(0.1))
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Workspace Details")
    }
}

// Preview
struct WorkspaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceDetailView(workspace: WorkspaceManager.shared.getWorkspaces()[0])
    }
}

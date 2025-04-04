//
//  WorkspaceCard.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 01/04/25.
//


import SwiftUI
import SwiftUI

struct WorkspaceCard: View {
    let workspace: Workspace

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                Image(workspace.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 246, height: 142)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            HStack(spacing: 40) {
                Text(workspace.name)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(hex: "262860"))

                if let gigsOpen = workspace.gigsOpen {
                    Text(gigsOpen)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .frame(height: 24)
                        .background(Color(hex: "262860"))
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                }
            }

            Text(workspace.distance)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)

            HStack(spacing: 6) {
                ForEach(workspace.features, id: \.self) { feature in
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color(hex: "262860"))
                        Text(feature)
                            .font(.system(size: 8))
                            .foregroundColor(Color(hex: "262860"))
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(Color(hex: "EDEDF7"))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }

            Text("Offer - " + workspace.offer)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "9A9A9A"))

            Text(workspace.price)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(hex: "262860"))

            NavigationLink(destination: BookingView(workspaceName: workspace.name)) {
                Text("Book")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color(hex: "262860"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .frame(width: 260, height: 340)
        .background(Color(hex: "262860").opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

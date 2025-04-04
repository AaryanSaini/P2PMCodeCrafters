//
//  AboutView.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//
import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
            Section(header: Text("App Information")) {
                HStack {
                    Text("App Name")
                    Spacer()
                    Text("P2PM")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("App Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("About")
    }
}

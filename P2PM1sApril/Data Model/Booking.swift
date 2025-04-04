//
//  Booking.swift
//  P2PM1sApril
//
//  Created by Abhay Singh on 02/04/25.
//

import Foundation
import SwiftUI

struct Booking: Identifiable, Codable {
    let id = UUID()
    let workspaceName: String
    let selectedDate: Date
    let numberOfPersons: Int
    let startTime: Date
    let endTime: Date
}

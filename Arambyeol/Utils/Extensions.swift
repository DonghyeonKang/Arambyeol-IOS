//
//  Extensions.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}

// MARK: - String Extensions
extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

// MARK: - Color Extensions
extension Color {
    static let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    static let secondaryGray = Color(red: 0.95, green: 0.95, blue: 0.97)
    static let accentGreen = Color(red: 0.2, green: 0.78, blue: 0.35)
    static let warningOrange = Color(red: 1.0, green: 0.58, blue: 0.0)
    static let errorRed = Color(red: 1.0, green: 0.23, blue: 0.19)
}

// MARK: - View Extensions
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.primaryBlue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.secondaryGray)
            .foregroundColor(.primary)
            .cornerRadius(10)
    }
}

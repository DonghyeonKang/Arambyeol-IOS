//
//  User.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation

// MARK: - User Model
struct User: BaseModel {
    let id: UUID
    let createdAt: Date
    var updatedAt: Date
    
    let name: String
    let email: String
    let profileImageURL: String?
    var isActive: Bool
    
    init(name: String, email: String, profileImageURL: String? = nil) {
        self.id = UUID()
        self.createdAt = Date()
        self.updatedAt = Date()
        self.name = name
        self.email = email
        self.profileImageURL = profileImageURL
        self.isActive = true
    }
}

// MARK: - User Extensions
extension User {
    static let sample = User(
        name: "샘플 사용자",
        email: "sample@example.com",
        profileImageURL: nil
    )
}

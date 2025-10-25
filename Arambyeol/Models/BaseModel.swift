//
//  BaseModel.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation

// MARK: - Base Model Protocol
protocol BaseModel: Codable, Identifiable {
    var id: UUID { get }
    var createdAt: Date { get }
    var updatedAt: Date { get }
}

// MARK: - Base Model Implementation
class BaseModelImpl: BaseModel {
    let id: UUID
    let createdAt: Date
    var updatedAt: Date
    
    init() {
        self.id = UUID()
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    func updateTimestamp() {
        self.updatedAt = Date()
    }
}

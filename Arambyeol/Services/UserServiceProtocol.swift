//
//  UserServiceProtocol.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - User Service Protocol
protocol UserServiceProtocol {
    func fetchCurrentUser() -> AnyPublisher<User, Error>
    func updateUser(_ user: User) -> AnyPublisher<User, Error>
    func deleteUser() -> AnyPublisher<Void, Error>
}

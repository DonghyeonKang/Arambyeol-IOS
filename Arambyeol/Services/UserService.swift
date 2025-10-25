//
//  UserService.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - User Service Implementation
class UserService: UserServiceProtocol {
    
    // MARK: - Mock Data for Development
    private let mockUser = User.sample
    
    // MARK: - Public Methods
    func fetchCurrentUser() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            // 실제 앱에서는 네트워크 요청을 여기서 수행
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                promise(.success(self.mockUser))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateUser(_ user: User) -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            // 실제 앱에서는 서버에 업데이트 요청을 보냄
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                promise(.success(user))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteUser() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            // 실제 앱에서는 서버에 삭제 요청을 보냄
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}

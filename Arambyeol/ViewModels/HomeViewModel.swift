//
//  HomeViewModel.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - Home ViewModel
class HomeViewModel: BaseViewModelImpl {
    @Published var user: User?
    @Published var welcomeMessage: String = ""
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        super.init()
        setupBindings()
    }
    
    // MARK: - Setup
    @MainActor
    private func setupBindings() {
        // 사용자 정보가 변경될 때 환영 메시지 업데이트
        $user
            .map { user in
                guard let user = user else { return "안녕하세요!" }
                return "안녕하세요, \(user.name)님!"
            }
            .assign(to: &$welcomeMessage)
    }
    
    // MARK: - Actions
    @MainActor
    func loadUser() {
        setLoading(true)
        clearError()
        
        userService.fetchCurrentUser()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.setLoading(false)
                    if case .failure(let error) = completion {
                        self?.handleError(error)
                    }
                },
                receiveValue: { [weak self] user in
                    self?.user = user
                }
            )
            .store(in: &cancellables)
    }
    
    @MainActor
    func refreshData() {
        loadUser()
    }
}

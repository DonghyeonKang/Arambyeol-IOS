//
//  BaseViewModel.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - Base ViewModel Protocol
@MainActor
protocol BaseViewModel: ObservableObject {
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
}

// MARK: - Base ViewModel Implementation
class BaseViewModelImpl: BaseViewModel {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var cancellables = Set<AnyCancellable>()
    
    @MainActor
    func setLoading(_ loading: Bool) {
        isLoading = loading
    }
    
    @MainActor
    func setError(_ error: String?) {
        errorMessage = error
    }
    
    @MainActor
    func clearError() {
        errorMessage = nil
    }
    
    // MARK: - Error Handling
    @MainActor
    func handleError(_ error: Error) {
        self.errorMessage = error.localizedDescription
    }
    
    // MARK: - Cancellables Management
    func addCancellable(_ cancellable: AnyCancellable) {
        cancellables.insert(cancellable)
    }
    
    deinit {
        cancellables.removeAll()
    }
}

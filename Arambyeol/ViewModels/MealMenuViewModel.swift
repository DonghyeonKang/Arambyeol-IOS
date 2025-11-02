//
//  MealMenuViewModel.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - Meal Menu ViewModel
class MealMenuViewModel: BaseViewModelImpl {
    @Published var currentPlan: PlanResponse?
    
    private let planService: PlanServiceProtocol
    
    init(planService: PlanServiceProtocol = PlanService()) {
        self.planService = planService
        super.init()
    }
    
    @MainActor
    func loadDailyPlan(date: String) {
        setLoading(true)
        clearError()
        
        planService.fetchDailyPlan(date: date)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.setLoading(false)
                    if case .failure(let error) = completion {
                        self?.handleError(error)
                    }
                },
                receiveValue: { [weak self] plan in
                    self?.currentPlan = plan
                }
            )
            .store(in: &cancellables)
    }
}


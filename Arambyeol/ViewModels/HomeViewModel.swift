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
    @Published var plans: [PlanResponse] = []
    @Published var todayPlan: PlanResponse?
    
    private let userService: UserServiceProtocol
    private let planService: PlanServiceProtocol
    
    init(
        userService: UserServiceProtocol = UserService(),
        planService: PlanServiceProtocol = PlanService()
    ) {
        self.userService = userService
        self.planService = planService
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
    func loadPlans() {
        setLoading(true)
        clearError()
        
        // 오늘 날짜 문자열 생성
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: Date())
        
        // 오늘 식단과 향후 식단을 동시에 로드
        let todayPlanPublisher = planService.fetchDailyPlan(date: todayString)
            .catch { _ in Empty<PlanResponse, Error>() }
        
        let futurePlansPublisher = planService.fetchFuturePlans()
            .catch { _ in Just<[PlanResponse]>([]).setFailureType(to: Error.self) }
        
        Publishers.Zip(todayPlanPublisher, futurePlansPublisher)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.setLoading(false)
                    if case .failure(let error) = completion {
                        // 데이터가 하나라도 로드되었으면 오류로 표시하지 않음
                        if self?.plans.isEmpty == true && self?.todayPlan == nil {
                            self?.handleError(error)
                        }
                    }
                },
                receiveValue: { [weak self] todayPlan, futurePlans in
                    self?.todayPlan = todayPlan
                    // 오늘 식단이 있으면 추가하고, 향후 식단과 합치기
                    var allPlans: [PlanResponse] = []
                    if !todayPlan.date.isEmpty {
                        allPlans.append(todayPlan)
                    }
                    // 중복 제거 (오늘 날짜가 향후 식단에 포함될 수 있음)
                    let todayDate = todayPlan.date
                    let uniqueFuturePlans = futurePlans.filter { $0.date != todayDate }
                    allPlans.append(contentsOf: uniqueFuturePlans)
                    self?.plans = allPlans
                    self?.setLoading(false)
                }
            )
            .store(in: &cancellables)
    }
    
    @MainActor
    func refreshData() {
        loadUser()
        loadPlans()
    }
}

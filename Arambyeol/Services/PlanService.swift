//
//  PlanService.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - Plan Endpoint
enum PlanEndpoint: APIEndpoint {
    case futurePlans
    case dailyPlan(date: String)
    case weeklyPlan(date: String)
    
    var baseURL: String {
        return AppConstants.API.baseURL
    }
    
    var path: String {
        switch self {
        case .futurePlans:
            return "/plans"
        case .dailyPlan(let date):
            return "/plans/\(date)"
        case .weeklyPlan(let date):
            return "/plans/weekly/\(date)"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    var body: Data? {
        return nil
    }
}

// MARK: - Plan Service Implementation
class PlanService: PlanServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchFuturePlans() -> AnyPublisher<[PlanResponse], Error> {
        return networkService.request(PlanEndpoint.futurePlans, responseType: [PlanResponse].self)
    }
    
    func fetchDailyPlan(date: String) -> AnyPublisher<PlanResponse, Error> {
        return networkService.request(PlanEndpoint.dailyPlan(date: date), responseType: PlanResponse.self)
    }
    
    func fetchWeeklyPlan(date: String) -> AnyPublisher<[PlanResponse], Error> {
        return networkService.request(PlanEndpoint.weeklyPlan(date: date), responseType: [PlanResponse].self)
    }
}


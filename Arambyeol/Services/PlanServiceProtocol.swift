//
//  PlanServiceProtocol.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - Plan Service Protocol
protocol PlanServiceProtocol {
    /// 향후 식단 조회 (오늘 이후의 모든 식단)
    func fetchFuturePlans() -> AnyPublisher<[PlanResponse], Error>
    
    /// 특정 날짜의 식단 조회
    func fetchDailyPlan(date: String) -> AnyPublisher<PlanResponse, Error>
    
    /// 주간 식단 조회 (지정된 날짜가 포함된 주)
    func fetchWeeklyPlan(date: String) -> AnyPublisher<[PlanResponse], Error>
}


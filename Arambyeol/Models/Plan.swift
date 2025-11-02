//
//  Plan.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation

// MARK: - Meal Type Enum
enum MealType: String, Codable, CaseIterable {
    case breakfast = "BREAKFAST"
    case lunch = "LUNCH"
    case dinner = "DINNER"
    
    var displayName: String {
        switch self {
        case .breakfast:
            return "조식"
        case .lunch:
            return "중식"
        case .dinner:
            return "석식"
        }
    }
}

// MARK: - Daily Menu Model
struct DailyMenu: Codable, Identifiable {
    let menuId: Int
    let menuName: String
    let mealType: MealType
    let course: String
    let imgPath: String?
    let averageScore: Double?
    let reviewCount: Int
    
    var id: Int { menuId }
}

// MARK: - Plan Response Model
struct PlanResponse: Codable, Identifiable {
    let date: String
    let menusByMealType: [String: [DailyMenu]]
    
    var id: String { date }
    
    // 편의 메서드: 특정 식사 타입의 메뉴 가져오기
    func menus(for mealType: MealType) -> [DailyMenu] {
        return menusByMealType[mealType.rawValue] ?? []
    }
    
    // 모든 메뉴를 식사 타입별로 정렬해서 반환
    var sortedMenus: [(MealType, [DailyMenu])] {
        return MealType.allCases.compactMap { mealType in
            let menus = self.menus(for: mealType)
            return menus.isEmpty ? nil : (mealType, menus)
        }
    }
    
    // 날짜를 Date 객체로 변환
    var dateValue: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date)
    }
    
    // 오늘 날짜인지 확인
    var isToday: Bool {
        guard let planDate = dateValue else { return false }
        let calendar = Calendar.current
        return calendar.isDateInToday(planDate)
    }
}


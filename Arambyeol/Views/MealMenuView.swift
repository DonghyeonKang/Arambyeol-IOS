//
//  MealMenuView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Meal Menu View
struct MealMenuView: View {
    let selectedDateString: String?
    @State private var selectedDate: Date
    @State private var selectedMealType: MealTypeEnum = .breakfast
    @StateObject private var viewModel = MealMenuViewModel()
    
    init(selectedDateString: String? = nil) {
        self.selectedDateString = selectedDateString
        if let dateString = selectedDateString {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            _selectedDate = State(initialValue: formatter.date(from: dateString) ?? Date())
        } else {
            _selectedDate = State(initialValue: Date())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 날짜 선택 섹션
                datePickerSection
                
                // 메뉴 타입 선택 탭
                mealTypePicker
                
                // 메뉴 리스트
                menuList
            }
            .navigationTitle("식단")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                loadPlanForDate(selectedDate)
            }
            .toolbar {
                // toolbar를 비워서 우상단 새로고침 버튼 제거
            }
        }
    }
    
    // MARK: - Date Picker Section
    private var datePickerSection: some View {
        VStack(spacing: 12) {
            DatePicker("날짜 선택", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
            
            Divider()
        }
        .background(Color(.systemBackground))
        .padding(.top, 0)
    }
    
    // MARK: - Meal Type Picker
    private var mealTypePicker: some View {
        Picker("식사 타입", selection: $selectedMealType) {
            Text("조식").tag(MealTypeEnum.breakfast)
            Text("중식").tag(MealTypeEnum.lunch)
            Text("석식").tag(MealTypeEnum.dinner)
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    // MARK: - Menu List
    private var menuList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.isLoading {
                    ProgressView("로딩 중...")
                        .frame(maxWidth: .infinity)
                        .padding()
                } else if let plan = viewModel.currentPlan {
                    ForEach(plan.sortedMenus, id: \.0.rawValue) { mealType, menus in
                        if mealType.rawValue == selectedMealType.apiValue {
                            menuSection(menus: menus)
                        }
                    }
                    
                    if plan.menus(for: MealType(rawValue: selectedMealType.apiValue) ?? .breakfast).isEmpty {
                        emptyMenuView
                    }
                } else {
                    emptyMenuView
                }
            }
            .padding()
        }
        .onChange(of: selectedDate) { newDate in
            loadPlanForDate(newDate)
        }
        .onAppear {
            loadPlanForDate(selectedDate)
        }
    }
    
    private func loadPlanForDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        viewModel.loadDailyPlan(date: dateString)
    }
    
    // MARK: - Menu Section
    private func menuSection(menus: [DailyMenu]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // 코스별로 그룹화
            let groupedByCourse = Dictionary(grouping: menus) { $0.course }
            
            ForEach(Array(groupedByCourse.keys.sorted()), id: \.self) { course in
                VStack(alignment: .leading, spacing: 8) {
                    Text(course)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    ForEach(groupedByCourse[course] ?? [], id: \.menuId) { menu in
                        menuRow(menu: menu)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    // MARK: - Menu Row
    private func menuRow(menu: DailyMenu) -> some View {
        HStack(spacing: 12) {
            // 평점 표시
            if let score = menu.averageScore {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", score))
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(6)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(menu.menuName)
                    .font(.body)
                    .fontWeight(.medium)
                
                if menu.reviewCount > 0 {
                    Text("리뷰 \(menu.reviewCount)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.leading, 8)
    }
    
    // MARK: - Empty Menu View
    private var emptyMenuView: some View {
        VStack(spacing: 12) {
            Image(systemName: "fork.knife")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text("해당 날짜의 식단 정보가 없습니다")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Meal Type Enum for UI
enum MealTypeEnum: String, CaseIterable {
    case breakfast = "조식"
    case lunch = "중식"
    case dinner = "석식"
    
    var apiValue: String {
        switch self {
        case .breakfast:
            return "BREAKFAST"
        case .lunch:
            return "LUNCH"
        case .dinner:
            return "DINNER"
        }
    }
}

// MARK: - Preview
#Preview {
    MealMenuView()
}


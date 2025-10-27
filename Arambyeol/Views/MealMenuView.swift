//
//  MealMenuView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Meal Menu View
struct MealMenuView: View {
    @State private var selectedDate = Date()
    @State private var selectedMealType: MealType = .breakfast
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // 새로고침 기능
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
    
    // MARK: - Date Picker Section
    private var datePickerSection: some View {
        VStack(spacing: 12) {
            DatePicker("날짜 선택", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding(.horizontal)
                .padding(.vertical, 8)
            
            Divider()
        }
        .background(Color(.systemBackground))
    }
    
    // MARK: - Meal Type Picker
    private var mealTypePicker: some View {
        Picker("식사 타입", selection: $selectedMealType) {
            Text("조식").tag(MealType.breakfast)
            Text("중식").tag(MealType.lunch)
            Text("석식").tag(MealType.dinner)
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    // MARK: - Menu List
    private var menuList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 메인 메뉴
                menuSection(title: "메인", items: sampleMenu.mainDish)
                
                // 국물류
                menuSection(title: "국물", items: sampleMenu.soup)
                
                // 반찬
                menuSection(title: "반찬", items: sampleMenu.sideDish)
            }
            .padding()
        }
    }
    
    // MARK: - Menu Section
    private func menuSection(title: String, items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            ForEach(items, id: \.self) { item in
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 6, height: 6)
                    Text(item)
                        .font(.body)
                }
                .padding(.leading, 8)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    // MARK: - Sample Menu Data
    private var sampleMenu: Menu {
        Menu(
            mainDish: ["백반", "김치볶음밥"],
            soup: ["된장국", "미역국"],
            sideDish: ["계란찜", "김치", "나물볶음"]
        )
    }
}

// MARK: - Meal Type
enum MealType: String, CaseIterable {
    case breakfast = "조식"
    case lunch = "중식"
    case dinner = "석식"
}

// MARK: - Menu Model
struct Menu {
    let mainDish: [String]
    let soup: [String]
    let sideDish: [String]
}

// MARK: - Preview
#Preview {
    MealMenuView()
}


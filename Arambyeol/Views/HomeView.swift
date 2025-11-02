//
//  HomeView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Home View
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 헤더 섹션
                    headerSection
                    
                    // 오늘의 식단 섹션
                    todayMealSection
                    
                    // 메인 콘텐츠
                    mainContentSection
                    
                    // 향후 식단 섹션
                    futurePlansSection
                    
                    // 액션 버튼들
                    actionButtonsSection
                }
                .padding()
            }
            .navigationTitle("홈")
            .refreshable {
                viewModel.refreshData()
            }
            .toolbar {
                // toolbar를 비워서 우상단 버튼 제거
            }
            .onAppear {
                viewModel.loadUser()
                viewModel.loadPlans()
            }
            .alert("오류", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("확인") {
                    viewModel.clearError()
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(viewModel.welcomeMessage)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Today Meal Section
    private var todayMealSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("오늘의 식단")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                if let todayPlan = viewModel.todayPlan {
                    Text(todayPlan.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            if viewModel.isLoading && viewModel.todayPlan == nil {
                ProgressView("식단 로딩 중...")
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if let todayPlan = viewModel.todayPlan {
                mealPlanCard(plan: todayPlan)
            } else {
                emptyMealView
            }
        }
    }
    
    // MARK: - Meal Plan Card
    private func mealPlanCard(plan: PlanResponse) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(plan.sortedMenus, id: \.0.rawValue) { mealType, menus in
                VStack(alignment: .leading, spacing: 8) {
                    Text(mealType.displayName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    
                    ForEach(menus, id: \.menuId) { menu in
                        menuRow(menu: menu)
                    }
                }
                .padding(.vertical, 8)
                
                if mealType != plan.sortedMenus.last?.0 {
                    Divider()
                }
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
                
                HStack(spacing: 8) {
                    Text(menu.course)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if menu.reviewCount > 0 {
                        Text("리뷰 \(menu.reviewCount)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    // MARK: - Empty Meal View
    private var emptyMealView: some View {
        VStack(spacing: 12) {
            Image(systemName: "fork.knife")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text("오늘의 식단 정보가 없습니다")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    // MARK: - Future Plans Section
    private var futurePlansSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !viewModel.plans.isEmpty {
                HStack {
                    Text("향후 식단")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(viewModel.plans.count)일")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // 최대 3개의 향후 식단만 표시 (오늘 제외)
                let futurePlans = viewModel.plans
                    .filter { $0.date != viewModel.todayPlan?.date }
                    .prefix(3)
                
                if !futurePlans.isEmpty {
                    ForEach(Array(futurePlans), id: \.id) { plan in
                        NavigationLink(destination: MealMenuView(selectedDateString: plan.date).navigationBarTitleDisplayMode(.inline)) {
                            futurePlanRow(plan: plan)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    Text("향후 식단이 없습니다")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
    }
    
    // MARK: - Future Plan Row
    private func futurePlanRow(plan: PlanResponse) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(plan.date)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                let totalMenus = plan.menusByMealType.values.flatMap { $0 }.count
                Text("\(totalMenus)개의 메뉴")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    // MARK: - Main Content Section
    private var mainContentSection: some View {
        VStack(spacing: 16) {
            if viewModel.isLoading && viewModel.user == nil {
                ProgressView("로딩 중...")
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if let user = viewModel.user {
                userInfoCard(user: user)
            }
        }
    }
    
    // MARK: - User Info Card
    private func userInfoCard(user: User) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("사용자 정보")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Circle()
                    .fill(user.isActive ? .green : .red)
                    .frame(width: 12, height: 12)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                infoRow(title: "이름", value: user.name)
                infoRow(title: "이메일", value: user.email)
                infoRow(title: "상태", value: user.isActive ? "활성" : "비활성")
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    // MARK: - Info Row
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
    
    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.circle")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("사용자 정보가 없습니다")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("새로고침 버튼을 눌러 데이터를 불러오세요")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    // MARK: - Action Buttons Section
    private var actionButtonsSection: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: MealMenuView().navigationBarTitleDisplayMode(.inline)) {
                HStack {
                    Image(systemName: "calendar")
                    Text("전체 식단 보기")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

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
            VStack(spacing: 20) {
                // 헤더 섹션
                headerSection
                
                // 메인 콘텐츠
                mainContentSection
                
                Spacer()
                
                // 액션 버튼들
                actionButtonsSection
            }
            .padding()
            .navigationTitle("홈")
            .onAppear {
                viewModel.loadUser()
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
    
    // MARK: - Main Content Section
    private var mainContentSection: some View {
        VStack(spacing: 16) {
            if viewModel.isLoading {
                ProgressView("로딩 중...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let user = viewModel.user {
                userInfoCard(user: user)
            } else {
                emptyStateView
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
            Button(action: {
                viewModel.refreshData()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("새로고침")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(viewModel.isLoading)
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

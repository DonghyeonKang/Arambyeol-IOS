//
//  ComponentsView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Components View (재사용 가능한 컴포넌트들)
struct ComponentsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 카드 컴포넌트 예시
                CardView(title: "카드 컴포넌트", content: "재사용 가능한 카드 뷰입니다.")
                
                // 버튼 컴포넌트 예시
                VStack(spacing: 12) {
                    PrimaryButton(title: "기본 버튼") {
                        print("기본 버튼 클릭")
                    }
                    
                    SecondaryButton(title: "보조 버튼") {
                        print("보조 버튼 클릭")
                    }
                }
                
                // 로딩 컴포넌트 예시
                LoadingView(message: "로딩 중...")
            }
            .padding()
        }
        .navigationTitle("컴포넌트")
    }
}

// MARK: - Card View Component
struct CardView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            Divider()
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Primary Button Component
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

// MARK: - Secondary Button Component
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray5))
                .foregroundColor(.primary)
                .cornerRadius(10)
        }
    }
}

// MARK: - Loading View Component
struct LoadingView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .scaleEffect(1.2)
            
            Text(message)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        ComponentsView()
    }
}

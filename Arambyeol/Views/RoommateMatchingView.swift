//
//  RoommateMatchingView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Roommate Matching View
struct RoommateMatchingView: View {
    @State private var selectedFilter: MatchingFilter = .all
    @State private var showingDetail = false
    @State private var selectedProfile: RoommateProfile?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 필터 섹션
                filterSection
                
                // 프로필 리스트
                profileList
            }
            .navigationTitle("룸메 매칭")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // 내 프로필 등록
                    }) {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                }
            }
            .sheet(item: $selectedProfile) { profile in
                ProfileDetailView(profile: profile)
            }
        }
    }
    
    // MARK: - Filter Section
    private var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(MatchingFilter.allCases, id: \.self) { filter in
                    FilterButton(
                        title: filter.title,
                        isSelected: selectedFilter == filter
                    ) {
                        selectedFilter = filter
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGray6))
    }
    
    // MARK: - Profile List
    private var profileList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredProfiles) { profile in
                    ProfileCard(profile: profile) {
                        selectedProfile = profile
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Filtered Profiles
    private var filteredProfiles: [RoommateProfile] {
        if selectedFilter == .all {
            return sampleProfiles
        } else {
            return sampleProfiles.filter { $0.gender == selectedFilter }
        }
    }
}

// MARK: - Matching Filter
enum MatchingFilter: String, CaseIterable {
    case all = "전체"
    case male = "남자"
    case female = "여자"
    
    var title: String {
        rawValue
    }
}

// MARK: - Roommate Profile Model
struct RoommateProfile: Identifiable {
    let id: UUID
    let name: String
    let gender: MatchingFilter
    let grade: String
    let department: String
    let habits: [String]
    let preferredRoomType: String
    let introduction: String
    let imageName: String
}

// MARK: - Profile Card
struct ProfileCard: View {
    let profile: RoommateProfile
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // 헤더
                HStack {
                    Circle()
                        .fill(profile.gender == .male ? Color.blue : Color.pink)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(profile.name.prefix(1))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(profile.name)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(profile.department)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text(profile.grade)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(profile.gender == .male ? Color.blue.opacity(0.2) : Color.pink.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Divider()
                
                // 습관 태그
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(profile.habits, id: \.self) { habit in
                            Text(habit)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                        }
                    }
                }
                
                // 방 타입
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.blue)
                    Text("선호 방 타입: \(profile.preferredRoomType)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Filter Button
struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

// MARK: - Profile Detail View
struct ProfileDetailView: View {
    let profile: RoommateProfile
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 프로필 이미지 및 기본 정보
                    profileHeader
                    
                    Divider()
                    
                    // 자기소개
                    introductionSection
                    
                    // 생활 패턴
                    habitsSection
                    
                    // 연락 버튼
                    contactButton
                }
                .padding()
            }
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var profileHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Circle()
                    .fill(profile.gender == .male ? Color.blue : Color.pink)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text(profile.name.prefix(1))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(profile.department)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("\(profile.grade) 학년")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
        }
    }
    
    private var introductionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("자기소개")
                .font(.headline)
            
            Text(profile.introduction)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
    
    private var habitsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("생활 패턴")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                ForEach(profile.habits, id: \.self) { habit in
                    Text(habit)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
        }
    }
    
    private var contactButton: some View {
        Button(action: {
            // 연락 기능
        }) {
            Text("연락하기")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

// MARK: - Sample Data
private let sampleProfiles: [RoommateProfile] = [
    RoommateProfile(
        id: UUID(),
        name: "김철수",
        gender: .male,
        grade: "2",
        department: "컴퓨터과학과",
        habits: ["조용한", "깔끔한", "야행성"],
        preferredRoomType: "2인실",
        introduction: "안녕하세요! 조용한 환경을 선호합니다.",
        imageName: "profile1"
    ),
    RoommateProfile(
        id: UUID(),
        name: "이영희",
        gender: .female,
        grade: "1",
        department: "경영학과",
        habits: ["활발한", "일찍 일어남", "깔끔한"],
        preferredRoomType: "4인실",
        introduction: "긍정적인 에너지로 함께 생활하고 싶어요!",
        imageName: "profile2"
    ),
    RoommateProfile(
        id: UUID(),
        name: "박민수",
        gender: .male,
        grade: "3",
        department: "전기공학과",
        habits: ["운동 좋아함", "벽두", "마당식성"],
        preferredRoomType: "2인실",
        introduction: "운동을 좋아하고 깔끔한 생활을 하고 싶습니다.",
        imageName: "profile3"
    )
]

// MARK: - Preview
#Preview {
    RoommateMatchingView()
}


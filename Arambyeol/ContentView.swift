//
//  ContentView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Main Content View
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 식단 탭
            MealMenuView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("식단")
                }
                .tag(0)
            
            // 채팅 탭
            ChatView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("채팅")
                }
                .tag(1)
            
            // 룸메 매칭 탭
            RoommateMatchingView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("룸메")
                }
                .tag(2)
            
            // 설정 탭
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @State private var isNotificationsEnabled = true
    @State private var selectedLanguage = "한국어"
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            List {
                // 프로필 섹션
                Section {
                    Button(action: {
                        showingProfile = true
                    }) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("김학생")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("학생생활관")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // 알림 설정
                Section("알림 설정") {
                    Toggle("푸시 알림", isOn: $isNotificationsEnabled)
                    Toggle("식단 알림", isOn: .constant(false))
                    Toggle("채팅 알림", isOn: .constant(true))
                }
                
                // 앱 설정
                Section("앱 설정") {
                    NavigationLink(destination: Text("정보 수정 화면")) {
                        Label("내 정보 수정", systemImage: "person.crop.circle")
                    }
                    
                    NavigationLink(destination: Text("차단 목록 화면")) {
                        Label("차단 관리", systemImage: "hand.raised")
                    }
                    
                    NavigationLink(destination: Text("고객센터 화면")) {
                        Label("고객센터", systemImage: "questionmark.circle")
                    }
                }
                
                // 정보
                Section("정보") {
                    HStack {
                        Text("앱 버전")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: Text("오픈소스 라이선스 화면")) {
                        Label("오픈소스 라이선스", systemImage: "doc.text")
                    }
                }
                
                // 계정
                Section {
                    Button(role: .destructive) {
                        // 로그아웃 처리
                    } label: {
                        HStack {
                            Spacer()
                            Text("로그아웃")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingProfile) {
                ProfileView()
            }
        }
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // 프로필 이미지
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 120, height: 120)
                        .overlay(
                            Text("김")
                                .font(.system(size: 60))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                    
                    // 기본 정보
                    VStack(spacing: 16) {
                        infoRow(title: "이름", value: "김학생")
                        infoRow(title: "학번", value: "20220001")
                        infoRow(title: "생활관", value: "경상국립대학교 학생생활관")
                        infoRow(title: "호실", value: "201호")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("내 프로필")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        dismiss()
                    }
                }
            }
        }
    }
    
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
}

// MARK: - Preview
#Preview {
    ContentView()
}

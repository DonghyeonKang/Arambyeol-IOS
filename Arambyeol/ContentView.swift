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
            // 홈 탭
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
                .tag(0)
            
            // 컴포넌트 탭
            ComponentsView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("컴포넌트")
                }
                .tag(1)
            
            // 설정 탭
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
                .tag(2)
        }
        .accentColor(.blue)
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @State private var isNotificationsEnabled = true
    @State private var selectedLanguage = "한국어"
    
    var body: some View {
        NavigationView {
            List {
                Section("알림 설정") {
                    Toggle("알림 허용", isOn: $isNotificationsEnabled)
                }
                
                Section("언어 설정") {
                    Picker("언어", selection: $selectedLanguage) {
                        Text("한국어").tag("한국어")
                        Text("English").tag("English")
                        Text("日本語").tag("日本語")
                    }
                    .pickerStyle(.menu)
                }
                
                Section("정보") {
                    HStack {
                        Text("앱 버전")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("빌드 번호")
                        Spacer()
                        Text("1")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("설정")
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

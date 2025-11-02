//
//  ChatView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Chat View
struct ChatView: View {
    var body: some View {
        NavigationView {
            ComingSoonView(title: "채팅")
                .navigationTitle("전체 채팅방")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // toolbar를 비워서 우상단 버튼 제거
                }
        }
    }
}

// MARK: - Coming Soon View
struct ComingSoonView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "clock.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("준비중입니다")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("\(title) 기능을 준비하고 있습니다.\n곧 만나요!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Preview
#Preview {
    ChatView()
}


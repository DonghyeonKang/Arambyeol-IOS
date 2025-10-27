//
//  ChatView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Chat View
struct ChatView: View {
    @State private var messages: [ChatMessage] = sampleMessages
    @State private var newMessage: String = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 메시지 리스트
                messageList
                
                // 입력 영역
                messageInputArea
            }
            .navigationTitle("전체 채팅방")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // 설정 기능
                    }) {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
    
    // MARK: - Message List
    private var messageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        messageBubble(message: message)
                            .id(message.id)
                    }
                }
                .padding()
            }
            .onChange(of: messages.count) { _ in
                // 새로운 메시지가 추가되면 스크롤
                withAnimation {
                    proxy.scrollTo(messages.last?.id, anchor: .bottom)
                }
            }
        }
    }
    
    // MARK: - Message Bubble
    private func messageBubble(message: ChatMessage) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !message.isMe {
                // 다른 사용자 메시지
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.senderName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(alignment: .bottom, spacing: 8) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(message.content)
                                .font(.body)
                                .foregroundColor(.primary)
                            
                            Text(message.timestamp, style: .time)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(12)
                        .background(Color(.systemGray5))
                        .cornerRadius(16, corners: [.topRight, .bottomRight, .bottomLeft])
                    }
                }
                
                Spacer()
            } else {
                // 내 메시지
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(alignment: .bottom, spacing: 8) {
                        VStack(alignment: .trailing, spacing: 6) {
                            Text(message.content)
                                .font(.body)
                                .foregroundColor(.white)
                            
                            Text(message.timestamp, style: .time)
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(12)
                        .background(Color.blue)
                        .cornerRadius(16, corners: [.topLeft, .bottomLeft, .bottomRight])
                    }
                }
            }
        }
    }
    
    // MARK: - Message Input Area
    private var messageInputArea: some View {
        HStack(spacing: 12) {
            TextField("메시지를 입력하세요...", text: $newMessage, axis: .vertical)
                .textFieldStyle(.plain)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .focused($isInputFocused)
                .lineLimit(1...4)
            
            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(newMessage.isEmpty ? .gray : .blue)
            }
            .disabled(newMessage.isEmpty)
        }
        .padding()
        .background(Color(.systemBackground))
    }
    
    // MARK: - Send Message
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        let message = ChatMessage(
            id: UUID(),
            content: newMessage,
            senderName: "나",
            timestamp: Date(),
            isMe: true
        )
        
        messages.append(message)
        newMessage = ""
    }
}

// MARK: - Chat Message Model
struct ChatMessage: Identifiable {
    let id: UUID
    let content: String
    let senderName: String
    let timestamp: Date
    let isMe: Bool
}

// MARK: - Sample Messages
private let sampleMessages: [ChatMessage] = [
    ChatMessage(id: UUID(), content: "오늘 식단 진짜 맛있네요!", senderName: "김학생", timestamp: Date().addingTimeInterval(-300), isMe: false),
    ChatMessage(id: UUID(), content: "저도 맛있게 먹었습니다 :)", senderName: "이학생", timestamp: Date().addingTimeInterval(-240), isMe: false),
    ChatMessage(id: UUID(), content: "내일은 뭐 나올까요?", senderName: "박학생", timestamp: Date().addingTimeInterval(-180), isMe: false),
]

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
#Preview {
    ChatView()
}


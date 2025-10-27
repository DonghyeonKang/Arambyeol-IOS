//
//  SplashScreenView.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

// MARK: - Splash Screen View
struct SplashScreenView: View {
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0.9
    
    var body: some View {
        ZStack {
            // 흰 배경
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                // 로고 이미지 - AppLogo 사용
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .cornerRadius(30)
                    .opacity(opacity)
                    .scaleEffect(scale)
                
                // 앱 이름
                Text("아람별")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.black)
                    .opacity(opacity)
            }
        }
        .onAppear {
            // 페이드 인 및 스케일 애니메이션
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                opacity = 1
                scale = 1.0
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SplashScreenView()
}


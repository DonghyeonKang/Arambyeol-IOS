//
//  ArambyeolApp.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import SwiftUI

@main
struct ArambyeolApp: App {
    @State private var isSplashScreenPresented = true
    
    var body: some Scene {
        WindowGroup {
            if isSplashScreenPresented {
                SplashScreenView()
                    .onAppear {
                        // 1.5초 후 메인 화면으로 전환
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isSplashScreenPresented = false
                            }
                        }
                    }
            } else {
                ContentView()
                    .transition(.opacity)
            }
        }
    }
}

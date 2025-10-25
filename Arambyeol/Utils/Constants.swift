//
//  Constants.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import SwiftUI

// MARK: - App Constants
struct AppConstants {
    
    // MARK: - App Info
    static let appName = "Arambyeol"
    static let appVersion = "1.0.0"
    static let buildNumber = "1"
    
    // MARK: - API Configuration
    struct API {
        static let baseURL = "https://api.arambyeol.com"
        static let timeout: TimeInterval = 30.0
        static let maxRetryCount = 3
    }
    
    // MARK: - UI Configuration
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 12
        static let animationDuration: Double = 0.3
    }
    
    // MARK: - UserDefaults Keys
    struct UserDefaultsKeys {
        static let isFirstLaunch = "isFirstLaunch"
        static let userToken = "userToken"
        static let selectedLanguage = "selectedLanguage"
        static let isNotificationsEnabled = "isNotificationsEnabled"
    }
    
    // MARK: - Notification Names
    struct NotificationNames {
        static let userDidLogin = Notification.Name("userDidLogin")
        static let userDidLogout = Notification.Name("userDidLogout")
        static let dataDidUpdate = Notification.Name("dataDidUpdate")
    }
}

// MARK: - Error Messages
struct ErrorMessages {
    static let networkError = "네트워크 연결을 확인해주세요."
    static let serverError = "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요."
    static let unknownError = "알 수 없는 오류가 발생했습니다."
    static let invalidInput = "입력한 정보가 올바르지 않습니다."
    static let noData = "데이터가 없습니다."
}

// MARK: - Success Messages
struct SuccessMessages {
    static let dataLoaded = "데이터가 성공적으로 로드되었습니다."
    static let dataSaved = "데이터가 성공적으로 저장되었습니다."
    static let dataDeleted = "데이터가 성공적으로 삭제되었습니다."
    static let operationCompleted = "작업이 완료되었습니다."
}

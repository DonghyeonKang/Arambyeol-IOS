//
//  Logger.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import os.log

// MARK: - Log Level
enum LogLevel: String, CaseIterable {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
    
    var emoji: String {
        switch self {
        case .debug: return "🔍"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "❌"
        }
    }
}

// MARK: - Logger
class Logger {
    static let shared = Logger()
    
    private let osLog = OSLog(subsystem: "com.arambyeol.app", category: "general")
    
    private init() {}
    
    // MARK: - Logging Methods
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }
    
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .info, message: message, file: file, function: function, line: line)
    }
    
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .warning, message: message, file: file, function: function, line: line)
    }
    
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .error, message: message, file: file, function: function, line: line)
    }
    
    // MARK: - Private Methods
    private func log(level: LogLevel, message: String, file: String, function: String, line: Int) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        let logMessage = "\(level.emoji) [\(level.rawValue)] \(fileName):\(line) \(function) - \(message)"
        
        #if DEBUG
        print(logMessage)
        #endif
        
        // OSLog를 사용한 시스템 로그
        os_log("%{public}@", log: osLog, type: osLogType(for: level), logMessage)
    }
    
    private func osLogType(for level: LogLevel) -> OSLogType {
        switch level {
        case .debug: return .debug
        case .info: return .info
        case .warning: return .default
        case .error: return .error
        }
    }
}

// MARK: - Convenience Extensions
extension Logger {
    func logError(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        self.error("\(error.localizedDescription)", file: file, function: function, line: line)
    }
    
    func logNetworkRequest(_ request: URLRequest, file: String = #file, function: String = #function, line: Int = #line) {
        debug("🌐 Request: \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "Unknown URL")", file: file, function: function, line: line)
    }
    
    func logNetworkResponse(_ response: URLResponse?, data: Data?, file: String = #file, function: String = #function, line: Int = #line) {
        if let httpResponse = response as? HTTPURLResponse {
            debug("📡 Response: \(httpResponse.statusCode)", file: file, function: function, line: line)
        }
    }
}

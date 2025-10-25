//
//  NetworkService.swift
//  Arambyeol
//
//  Created by donghyeon kang on 10/23/25.
//

import Foundation
import Combine

// MARK: - Network Error
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case networkUnavailable
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .noData:
            return "데이터를 받을 수 없습니다."
        case .decodingError:
            return "데이터를 해석할 수 없습니다."
        case .serverError(let code):
            return "서버 오류: \(code)"
        case .networkUnavailable:
            return "네트워크에 연결할 수 없습니다."
        }
    }
}

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func request<T: Codable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, Error>
}

// MARK: - API Endpoint Protocol
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

// MARK: - Network Service Implementation
class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Codable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        // 헤더 설정
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.networkUnavailable
                }
            }
            .eraseToAnyPublisher()
    }
}

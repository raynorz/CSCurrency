//
//  APIRequestConvertible.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

protocol APIRequestConvertible {
    var path: String { get }
    var baseURLComponents: URLComponents { get }
    var parameters: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var urlRequest: URLRequest? { get }
    
    func createUrlRequest() throws -> URLRequest
}

extension APIRequestConvertible {
    var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "webapi.developers.erstegroup.com"
        components.path = "/api/csas/public/sandbox/v2"

        components.queryItems = parameters

        return components
    }

    var urlRequest: URLRequest? {
        guard let url = baseURLComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("9a25846c-918e-4bae-865c-3c992df79ff7", forHTTPHeaderField: "WEB-API-key")
        request.url?.appendPathComponent(path)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }

    var httpBody: Data? {
        return nil
    }
}


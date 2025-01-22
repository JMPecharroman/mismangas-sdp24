//
//  URLRequest.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

extension URLRequest {
    static func createRequest(from endPoint: EndPoint) -> URLRequest {
        var request = URLRequest(url: endPoint.url)
        request.timeoutInterval = 60
        request.httpMethod = endPoint.method.rawValue
        
        endPoint.headers.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let body = endPoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
            
        return request
    }
    
    static func get(_ endPoint: EndPoint) -> URLRequest {
        print("URL: \(endPoint.url)")
        var request = URLRequest(url: endPoint.url)
        request.timeoutInterval = 60
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func get(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer LKJASLKJASLKJD", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func post<JSON>(url: URL, body: JSON, method: HTTPMethod = .post) -> URLRequest where JSON: Encodable {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }
}

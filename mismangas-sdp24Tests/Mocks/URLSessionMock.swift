//
//  URLSessionMockMangas.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

extension URL {
    static var bestMangasMockData: URL {
        Bundle.main.url(forResource: "BestMangasMockData", withExtension: "json")!
    }
    
    static var listMangasMockData: URL {
        Bundle.main.url(forResource: "ListMangasMockData", withExtension: "json")!
    }
}

extension URLSession {
    static var mock: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        
        return URLSession(configuration: config)
    }
}

final class URLSessionMock: URLProtocol {
    var urlTest: URL {
        Bundle.main.url(forResource: "EmpleadosPreview", withExtension: "json")!
    }
    var urlTestOne: URL {
        Bundle.main.url(forResource: "EmpleadosPreviewOne", withExtension: "json")!
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let url = request.url else { return }
        
        let path = url.path()
        
        if path == "/list/bestMangas" {
            guard let data = try? Data(contentsOf: .bestMangasMockData) else { return }
            guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json; charset=utf-8"]) else { return }
            
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        } else if path == "/list/mangas" {
            guard let data = try? Data(contentsOf: .listMangasMockData) else { return }
            guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json; charset=utf-8"]) else { return }
            
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}

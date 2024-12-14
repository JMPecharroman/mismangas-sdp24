//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

enum EndPoint {
    
    static let apiURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!
    
    case bestMangas
    case listMangas(page: Int)
    
    var url: URL {
        switch self {
            case .bestMangas:
                Self.apiURL.appendingPathComponent("list/bestMangas")
            case .listMangas(let page):
                Self.apiURL.appendingPathComponent("list/mangas").appending(queryItems: [.page(page)])
        }
    }
}

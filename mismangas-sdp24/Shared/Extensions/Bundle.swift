//
//  Bundle.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/12/24.
//

import Foundation

extension Bundle {
    func getJSON<T>(_ resource: String) throws -> T where T: Decodable {
        let fileURL = Bundle.main.url(forResource: resource, withExtension: "json")!
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

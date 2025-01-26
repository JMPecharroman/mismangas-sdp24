//
//  MangaDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import Foundation

extension MangaDTO {
    static var preview: MangaDTO {
        let listMangas: ListMangasResponse = try! Bundle.main.getJSON("ListMangasMockData")
        return listMangas.items.first!
    }
}

//
//  MangaViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 12/12/24.
//

import SwiftUI

@Observable
final class MangaViewModel {
    let manga: Manga
    
    init(_ manga: Manga) {
        self.manga = manga
    }
}

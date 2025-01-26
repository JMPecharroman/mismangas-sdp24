//
//  CollectionMangaViewModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

extension CollectionMangaViewModel {
    static var preview: CollectionMangaViewModel {
        CollectionMangaViewModel(data: .preview, repository: .preview, repositoryNetwork: .preview)
    }
}

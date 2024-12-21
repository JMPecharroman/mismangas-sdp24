//
//  ViewModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

extension AuthorViewModel {
    static var preview: AuthorViewModel {
        AuthorViewModel(author: .preview, repository: .preview)
    }
}

extension CategoryViewModel {
    static var preview: CategoryViewModel {
        CategoryViewModel(.preview)
    }
}

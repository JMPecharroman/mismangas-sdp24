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

extension CollectionViewModel {
    static var preview: CollectionViewModel {
        CollectionViewModel(repository: .preview)
    }
}

extension MangaViewModel {
    static var preview: MangaViewModel {
        MangaViewModel(.preview)
    }
}

extension SearchViewModel {
    static var preview: SearchViewModel {
        SearchViewModel(repository: .preview)
    }
}

extension SyncViewModel {
    static var preview: SyncViewModel {
        SyncViewModel(repository: .preview, repositoryNetwork: .preview)
    }
}

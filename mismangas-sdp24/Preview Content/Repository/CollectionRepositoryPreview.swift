//
//  CollectionViewModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

struct CollectionRepositoryPreview: CollectionRepository {
    
}

extension CollectionRepository where Self == CollectionRepositoryPreview {
    static var preview: CollectionRepository {
        CollectionRepositoryPreview()
    }
}

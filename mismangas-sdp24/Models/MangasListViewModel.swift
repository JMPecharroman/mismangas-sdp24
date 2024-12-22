//
//  MangasListViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

@Observable @MainActor
class MangasListViewModel {
    
    private(set) var errorMangas: Error?
    private(set) var isLoadingMangas: Bool = false
    private(set) var mangas: [Manga] = []
    private(set) var maxPage: Int = 1
    private(set) var page: Int = 1
    
    var canLoadMoreMangas: Bool {
        page <= maxPage
    }
    
    @RepositoryActor
    func getMangas() async {
        assertionFailure("Debe implementarse en la subclase")
    }
    
    func loadMoreMangas() {
        guard !isLoadingMangas else { return }
        guard canLoadMoreMangas else { return }
        
        isLoadingMangas = true
        errorMangas = nil
        
        Task {
            await getMangas()
        }
    }
    
    func onAppear() {
        guard mangas.isEmpty else { return }
        
        refreshMangas()
    }
    
    func refreshMangas() {
        guard !isLoadingMangas else { return }
        
        page = 1
        maxPage = 1
        
        loadMoreMangas()
    }
    
    func processError(_ error: Error) {
        self.errorMangas = error
        isLoadingMangas = false
    }
    
    func processResponse(_ response: MangasResponse) {
        self.mangas.append(contentsOf: response.mangas)
        self.maxPage = response.numberOfPages
        page += 1
        isLoadingMangas = false
    }
}

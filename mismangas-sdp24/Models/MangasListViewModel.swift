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
    private var lastFirstManga: Manga?
    private(set) var mangas: [Manga] = []
    private(set) var maxPage: Int = 1
    private(set) var page: Int = 1
    private var task: Task<Void, Never>?
    
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
        
        task?.cancel()
        task = Task {
            await getMangas()
        }
    }
    
    func mangaAppear(_ manga: Manga) {
        if manga.id == lastFirstManga?.id {
            loadMoreMangas()
        }
    }
    
    func onAppear() {
        guard mangas.isEmpty else { return }
        
        refreshMangas()
    }
    
    func refreshMangas(forceReload: Bool = false) {
        if forceReload {
            isLoadingMangas = false
            task?.cancel()
        } else {
            guard !isLoadingMangas else { return }
        }
        
        page = 1
        maxPage = 1
        
        loadMoreMangas()
    }
    
    func processError(_ error: Error) {
        self.errorMangas = error
        isLoadingMangas = false
    }
    
    func processResponse(_ response: MangasResponse) {
        maxPage = response.numberOfPages
        page += 1
        mangas.append(contentsOf: response.mangas)
        lastFirstManga = response.mangas.first
        isLoadingMangas = false
    }
    
    func processResponse(_ response: [Manga]) {
        maxPage = 1
        page = 1
        mangas = response
        lastFirstManga = nil
        isLoadingMangas = false
    }
}

//
//  AuthorsListContent.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 27/12/24.
//

import SwiftUI

struct AuthorsListContent: View {
    
    @Binding var vm: SearchViewModel
    
    var body: some View {
        if let error = vm.authorsError, vm.authors.isEmpty {
            SectionErrorView(error: error) {
                vm.refreshAuthors()
            }
        } else if vm.authors.isEmpty {
            if vm.isLoadingAuthors {
                LoadingListCell()
            } else {
                NoResultsView()
            }
        } else {
            ForEach(vm.authors) { author in
                AuthorCell(author: author)
            }
        }
    }
}

#Preview {
    AuthorsListContent(vm : .constant(SearchViewModel.preview))
}

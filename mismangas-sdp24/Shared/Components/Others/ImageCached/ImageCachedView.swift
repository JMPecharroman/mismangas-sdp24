//
//  ImageCached.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//


import SwiftUI

struct ImageCached: View {
    @State private var viewModel = ImageCachedViewModel()
    
    let url: URL?
    
    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
//                .scaledToFill()
        } else {
            VStack {
                ProgressView()
                    .controlSize(isWatch ? .mini : .extraLarge)
                    .onAppear {
                        Task {
                            await viewModel.getImageAsync(url: url)
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var isWatch: Bool {
        #if os(watchOS)
        true
        #else
        false
        #endif
    }
}

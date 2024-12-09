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
        } else {
            VStack {
                ProgressView()
                    .controlSize(.extraLarge)
                    .onAppear {
                        Task {
                            await viewModel.getImageAsync(url: url)
                        }
                    }
            }
        }
    }
}

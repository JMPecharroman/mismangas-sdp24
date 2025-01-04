//
//  CollectionMangaVolumesGrid.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct CollectionMangaVolumesGrid: View {
    
    @State var vm: CollectionMangaViewModel
    
    var body: some View {
        if let collectionManga = vm.data {
            if collectionManga.totalVolumes > 0 {
                LazyVGrid(columns: .adaptative(minimum: 210.0), spacing: 8.0) {
                    ForEach(1..<(collectionManga.totalVolumes + 1), id: \.self) { volumen in
                        HStack {
                            Text("Volume \(volumen)")
                            Spacer()
                            Image(systemName: "cart")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.blue)
                                .frame(width: 18.0, height: 18.0)
                                .padding(8.0)
                                .background(.blue.opacity(0.3))
                                .clipShape(Circle())
                            Image(systemName: "eye")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.green)
                                .frame(width: 18.0, height: 18.0)
                                .padding(8.0)
                                .background(.green.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(8.0)
                        .cardBackground()
                    }
                }
            }
        }
    }
}

#Preview {
    CollectionMangaVolumesGrid(vm: .preview)
}

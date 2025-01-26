//
//  CollectionMangaVolumeView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct CollectionMangaVolumeView: View {
    
    @Binding var vm: CollectionMangaViewModel
    
    @State private var circleSize: CGFloat = 8.0
    
    let volume: VolumeData
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    VStack(spacing: 8.0) {
                        Button {
                            vm.markAsOwned(!vm.volumeIsOwned(volume.id), volume: volume.id)
                        } label: {
                            Image(systemName: vm.volumeIsOwned(volume.id) ? "books.vertical" : "cart")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: circleSize, height: circleSize)
                                .padding(circleSize / 4)
                                .background(.blue.opacity(vm.volumeIsOwned(volume.id) ? 1.0 : 0.3))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        Text(vm.volumeIsOwned(volume.id) ? "Comprado" : "No comprado")
                            .lineLimit(1)
                            .shadow(color: .black.opacity(0.7), radius: 4)
                    }
                    .frame(width: geometry.size.width * 0.45)
                    Spacer()
                    VStack(spacing: 8.0) {
                        Button {
                            if vm.volumeIsRead(volume.id) {
                                vm.markAsUnread(volume: volume.id)
                            } else {
                                vm.markAsRead(volume: volume.id)
                            }
                        } label: {
                            Image(systemName: vm.volumeIsRead(volume.id) ? "checkmark" : "eye")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: circleSize, height: circleSize)
                                .padding(circleSize / 4)
                                .background(.green.opacity(vm.volumeIsRead(volume.id) ? 1.0 : 0.3))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        Text(vm.volumeIsRead(volume.id) ? "Leído" : "No leído")
                            .lineLimit(1)
                            .shadow(color: .black.opacity(0.7), radius: 4)
                    }
                    .frame(width: geometry.size.width * 0.45)
                    Spacer()
                }
                Spacer()
            }
            .loading(vm.isLoading)
            .blurImageBackground(url: vm.data?.cover, fullCover: true)
            .onAppear {
                circleSize = calculateCircleSize(geometry)
            }
        }
        .navigationTitle("Volumen \(volume.id)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func calculateCircleSize(_ geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.width * 0.2, geometry.size.height * 0.5)
    }
}

#Preview {
//    CollectionMangaVolumeView()
}

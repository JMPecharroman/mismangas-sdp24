//
//  CollectionMangaVolumesGrid.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct CollectionMangaVolumesGrid: View {
    
    @State var vm: CollectionMangaViewModel
    @State private var showMarkAsUnreadAlert: Bool = false
    @State private var selectedVolume: VolumeData?
    
    var body: some View {
        if let collectionManga = vm.data {
            if collectionManga.totalVolumes > 0 {
                LazyVGrid(columns: .adaptative(minimum: 210.0), spacing: 8.0) {
                    ForEach(vm.volumesData) { volume in
                        HStack {
                            Text("Volumen \(volume.id)")
                            Spacer()
                            Button {
                                vm.markAsOwned(!volume.isOwned, volume: volume.id)
                            } label: {
                                Image(systemName: volume.isOwned ? "books.vertical" : "cart")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(volume.isOwned ? .white : .blue)
                                    .frame(width: 18.0, height: 18.0)
                                    .padding(8.0)
                                    .background(.blue.opacity(volume.isOwned ? 1.0 : 0.3))
                                    .clipShape(Circle())
                            }
                            Button {
                                if volume.isRead {
                                    if vm.volumeIsRead(volume.id + 1) {
                                        selectedVolume = volume
                                        showMarkAsUnreadAlert = true
                                    } else {
                                        vm.markAsUnread(volume: volume.id)
                                    }
                                } else {
                                    vm.markAsRead(volume: volume.id)
                                }
                            } label: {
                                Image(systemName: volume.isRead ? "checkmark" : "eye")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(volume.isRead ? .white : .green)
                                    .frame(width: 18.0, height: 18.0)
                                    .padding(8.0)
                                    .background(.green.opacity(volume.isRead ? 1.0 : 0.3))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 12.0)
                        .padding(.vertical, 8.0)
                        .cardBackground()
                    }
                }
                .alert("No leído", isPresented: $showMarkAsUnreadAlert) {
                    Button(role: .destructive) {
                        guard let volume = selectedVolume else { return }
                        vm.markAsUnread(volume: volume.id)
                    } label: {
                        Text("Marcar como no leído")
                    }
                } message: {
                    Text("¿Estás seguro de marcar el volumen \(selectedVolume?.id ?? 0) como no leído? Todos los volúmenes posteriores también se desmarcarán.")
                }
            }
        }
    }
}

#Preview {
    CollectionMangaVolumesGrid(vm: .preview)
}

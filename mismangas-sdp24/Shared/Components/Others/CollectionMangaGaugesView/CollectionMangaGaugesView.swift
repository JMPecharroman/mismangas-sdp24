//
//  CollectionMangaGaugesView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 5/1/25.
//

import SwiftUI

struct CollectionMangaGaugesView: View {
    
    let collectionManga: CollectionManga
    
    var body: some View {
        HStack {
            VStack {
                Text(collectionManga.totalVolumes)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 60.0, height: 60.0, alignment: .center)
                    .background {
                        Circle()
                            .strokeBorder(.orange, lineWidth: 6.0)
                    }
                Text("Volúmenes")
                    .foregroundStyle(.orange)
                    .fontWeight(.semibold)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            VStack {
                Gauge(value: collectionManga.volumesOwnedPercentage) {
                    Text("Value")
                } currentValueLabel: {
                    Text("\(collectionManga.volumesOwnedCountLabel)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(.blue)
                Text("Comprados")
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            VStack {
                Gauge(value: collectionManga.volumesReadPercentage) {
                    Text("Value")
                } currentValueLabel: {
                    Text(collectionManga.readingVolume ?? 0)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(.green)
                Text("Leídos")
                    .foregroundStyle(.green)
                    .fontWeight(.semibold)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding()
        .cardBackground()
    }
}

#Preview {
    CollectionMangaGaugesView(collectionManga: .preview)
}

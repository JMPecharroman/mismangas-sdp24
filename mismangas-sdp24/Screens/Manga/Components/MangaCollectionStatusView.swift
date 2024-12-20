//
//  MangaCollectionStatusView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

struct MangaCollectionStatusView: View {
    
    let manga: Manga
    
    var body: some View {
        VStack(spacing: 16.0) {
            HStack {
                VStack {
                    Text(manga.volumesLabel)
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
                    Gauge(value: 0.3) {
                        Text("Value")
                    } currentValueLabel: {
                        Text("12")
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
                    Gauge(value: 0.3) {
                        Text("Value")
                    } currentValueLabel: {
                        Text("12")
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
                //                            Spacer()
            }
            
            //                        Button {
            //
            //                        } label: {
            //                            Text("Marcar volumen 3 como leído")
            //                                .frame(maxWidth: .infinity, alignment: .center)
            //                        }
            //                        .buttonStyle(.borderedProminent)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8.0)
                .fill(.regularMaterial)
        }
        .padding(.horizontal)
        
        Button {
            
        } label: {
            Text("Marcar volumen 3 como leído")
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .buttonStyle(.borderedProminent)
        .padding(.horizontal)
        .padding(.top, 8.0)
    }
}

#Preview {
    MangaCollectionStatusView(manga: .preview)
}

//
//  PreviewData.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 1/1/25.
//

import SwiftData
import SwiftUI

struct PreviewData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CollectionMangaSD.self, configurations: configuration)
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor
    static var sampleData: Self = .modifier(PreviewData())
}

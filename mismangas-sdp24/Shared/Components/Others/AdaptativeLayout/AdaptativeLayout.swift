//
//  AdaptativeLayout.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/1/25.
//

import SwiftUI

struct AdaptativeLayout<Content: View, PadContent: View>: View {
    let defaultContent: () -> Content
    let iPadContent: () -> PadContent
    
    @ViewBuilder
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            iPadContent()
        } else {
            defaultContent()
        }
    }
}

//
//  ContentView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(HomeView.viewTitle, systemImage: "house")
                }
        }
    }
}


#Preview {
    ContentView()
}

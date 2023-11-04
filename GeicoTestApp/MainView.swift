//
//  MainView.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CoreLocationView()
                .tabItem {
                    Label("Core Location",
                          systemImage: "location")
                }
            CoreMotionView()
                .tabItem {
                    Label("Core Motion",
                          systemImage: "circle.dotted.and.circle")
                }
            ContentView()
                .tabItem {
                    Label("Items",
                          systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    MainView()
}

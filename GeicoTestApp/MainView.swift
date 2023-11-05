//
//  MainView.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import SwiftUI

struct MainView: View {
    enum TabItem {
        case map, bubble, needle, graph
    }
    
    @StateObject private var locationModel = CoreLocationModel()
    @StateObject private var motionDetector = MotionDetector(updateInterval: 0.01)
    @State private var activeTab: TabItem = .map

    var body: some View {
        TabView(selection: $activeTab) {
            NavigationView {
                CoreLocationView()
                    .environmentObject(locationModel)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Map",
                      systemImage: "location")
            }
            .tag(TabItem.map)
            
            NavigationView {
                BubbleView()
                    .environmentObject(motionDetector)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Bubble",
                      systemImage: "scope")
            }
            .tag(TabItem.bubble)
            
            NavigationView {
                NeedleView()
                    .environmentObject(motionDetector)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Needle",
                      systemImage: "gauge.with.dots.needle.bottom.0percent")
            }
            .tag(TabItem.needle)
            
            NavigationView {
                GraphView()
                    .environmentObject(motionDetector)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Graph",
                      systemImage: "chart.xyaxis.line")
            }
            .tag(TabItem.graph)
        }
        .onChange(of: activeTab, initial: false) { old, new in
            motionDetector.stop()
            
            if new == TabItem.bubble ||
                new == TabItem.needle ||
                new == TabItem.graph {
                motionDetector.start()
            }
        }
    }
}

#Preview {
    MainView()
}

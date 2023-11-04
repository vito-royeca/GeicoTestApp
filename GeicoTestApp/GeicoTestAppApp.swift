//
//  GeicoTestAppApp.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import SwiftUI
import SwiftData

@main
struct GeicoTestAppApp: App {
    @StateObject private var locationModel = CoreLocationModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(locationModel)
        }
    }
}

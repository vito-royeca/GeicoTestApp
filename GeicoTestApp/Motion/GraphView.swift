//
//  GraphView.swift
//  GeicoTestApp
//
//  Created by Miguel Ponce de Monio III on 11/4/23.
//

import SwiftUI

struct GraphView: View {
    @EnvironmentObject var motionDetector: MotionDetector

    var body: some View {
        GraphSeismometer()
            .navigationTitle("Graph")
    }
}

#Preview {
    let motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    return GraphView()
        .environmentObject(motionDetector)
}

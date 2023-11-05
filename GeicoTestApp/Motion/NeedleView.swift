//
//  NeedleView.swift
//  GeicoTestApp
//
//  Created by Miguel Ponce de Monio III on 11/4/23.
//

import SwiftUI

struct NeedleView: View {
    @EnvironmentObject var motionDetector: MotionDetector

    var body: some View {
        NeedleSeismometer()
            .navigationTitle("Needle")
    }
}

#Preview {
    let motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    return NeedleView()
        .environmentObject(motionDetector)
}

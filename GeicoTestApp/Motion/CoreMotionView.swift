//
//  CoreMotionView.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import SwiftUI

struct CoreMotionView: View {
    @EnvironmentObject var motionDetector: MotionDetector

    var body: some View {
        VStack {
            BubbleLevel()
            OrientationDataView()
                .padding(.top, 80)
            NeedleSeismometer()
        }
        .onAppear {
            motionDetector.start()
        }
        .onDisappear {
            motionDetector.stop()
        }
    }
}

#Preview {
    let motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    return CoreMotionView()
        .environmentObject(motionDetector)
}

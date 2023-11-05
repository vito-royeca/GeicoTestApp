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
//        GeometryReader { reader in
            VStack() {
                BubbleLevel()
                OrientationDataView()
//                    .padding()
                    .padding(.top, 30)
                NeedleSeismometer()
            }
            .onAppear {
                motionDetector.start()
            }
            .onDisappear {
                motionDetector.stop()
            }
            .navigationTitle("Core Motion")
//        }
    }
}

#Preview {
    let motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    return CoreMotionView()
        .environmentObject(motionDetector)
}

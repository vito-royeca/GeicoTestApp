//
//  BubbleView.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import SwiftUI

struct BubbleView: View {
    @EnvironmentObject var motionDetector: MotionDetector

    var body: some View {
        VStack() {
            BubbleLevel()
            OrientationDataView()
                .padding(.top, 30)
        }
            .navigationTitle("Bubble")
    }
}

#Preview {
    let motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    return BubbleView()
        .environmentObject(motionDetector)
}

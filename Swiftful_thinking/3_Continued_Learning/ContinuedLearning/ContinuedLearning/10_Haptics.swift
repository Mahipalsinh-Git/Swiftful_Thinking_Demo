//
//  10_Haptics.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI

class HapticManager {
    static let instace = HapticManager()

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsDemo: View {
    var body: some View {
        VStack {
            Button("error") {
                HapticManager.instace.notification(type: .error)
            }
            Button("success") {
                HapticManager.instace.notification(type: .success)
            }
            Button("warning") {
                HapticManager.instace.notification(type: .warning)
            }

            Divider()

            Button("heavy") {
                HapticManager.instace.impact(style: .heavy)
            }
            Button("light") {
                HapticManager.instace.impact(style: .light)
            }
            Button("medium") {
                HapticManager.instace.impact(style: .medium)
            }
            Button("rigid") {
                HapticManager.instace.impact(style: .rigid)
            }
            Button("soft") {
                HapticManager.instace.impact(style: .soft)
            }
        }
    }
}

#Preview {
    HapticsDemo()
}

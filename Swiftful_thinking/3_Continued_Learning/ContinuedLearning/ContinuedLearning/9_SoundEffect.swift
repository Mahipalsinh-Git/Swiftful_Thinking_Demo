//
//  9_SoundEffect.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player : AVAudioPlayer?

    enum SoundOption: String {
        case tada
        case badum
    }

    func playSound(fileName: SoundOption) {
        guard let url = Bundle.main.url(forResource: fileName.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

struct SoundEffectDemo: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(fileName: .tada)
            }

            Button("Play sound 2") {
                SoundManager.instance.playSound(fileName: .badum)
            }
        }
    }
}

#Preview {
    SoundEffectDemo()
}

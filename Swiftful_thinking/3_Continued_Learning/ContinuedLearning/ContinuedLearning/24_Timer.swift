//
//  24_TimerDemo.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/18/24.
//

import SwiftUI

struct TimerDemo: View {

    let timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()

    // Current time
    @State var currentDate = Date()

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }

    // Countdown
    @State var count: Int = 100
    @State var finishedText: String? = nil

    //Countdown to date
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()

    // Animation counter
    @State var animationConter: Int = 0

    // Pageview
    @State var pageViewCount: Int = 4

    func updateTimeRemainig() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0

        timeRemaining = "\(hour):\(minute):\(second)"
    }

    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.teal]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
                            .ignoresSafeArea()

            VStack(spacing: 15) {
                Text(currentDate.description)
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)

                Text(dateFormatter.string(from: currentDate))
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)

                Text(finishedText ?? "\(count)")
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)

                Text(timeRemaining)
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)

                HStack(spacing: 15) {
                    Circle()
                        .offset(y: animationConter == 1 ? -20 : 0)
                    Circle()
                        .offset(y: animationConter == 2 ? -20 : 0)
                    Circle()
                        .offset(y: animationConter == 3 ? -20 : 0)
                }
                .frame(width: 100)
                .foregroundStyle(.white)

                TabView(selection: $pageViewCount) {
                    Rectangle()
                        .foregroundStyle(.red)
                        .tag(1)

                    Rectangle()
                        .foregroundStyle(.green)
                        .tag(2)

                    Rectangle()
                        .foregroundStyle(.pink)
                        .tag(3)

                    Rectangle()
                        .foregroundStyle(.orange)
                        .tag(4)
                }
                .tabViewStyle(.page)
            }
        }
        .onReceive(timer) { value in
            currentDate = value

            // Countdown
            if count <= 1 {
                finishedText = "Done!"
            } else {
                count -= 1
            }

            // Countdown to date
            updateTimeRemainig()

            // Animation counter
            withAnimation(.easeInOut(duration: 1.0)) {
                animationConter = animationConter == 3 ? 0 : animationConter + 1
            }

            // Tabview timer
            withAnimation(.default) {
                pageViewCount = pageViewCount == 4 ? 1 : pageViewCount + 1
            }
        }
    }
}

#Preview {
    TimerDemo()
}

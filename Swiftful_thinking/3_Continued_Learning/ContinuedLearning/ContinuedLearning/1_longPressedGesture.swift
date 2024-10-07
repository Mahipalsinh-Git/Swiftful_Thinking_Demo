//
//  ContentView.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 21/08/24.
//

import SwiftUI

struct LongPressedGestureDemo: View {

    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text(isComplete ? "Completed" : "Not Completed")
                .padding()
                .padding(.horizontal)
                .background(isComplete ? .green : .gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onLongPressGesture {
                    isComplete.toggle()
                }

            Text(isComplete ? "Completed" : "Not Completed")
                .padding()
                .padding(.horizontal)
                .background(isComplete ? .green : .gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onLongPressGesture(minimumDuration: 3) {
                    isComplete.toggle()
                }

            Text(isComplete ? "Completed" : "Not Completed")
                .padding()
                .padding(.horizontal)
                .background(isComplete ? .green : .gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onLongPressGesture(minimumDuration: 3, maximumDistance: 1) {
                    isComplete.toggle()
                }

            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)

            HStack {
                Text("Click")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onLongPressGesture(minimumDuration:1.0) {
                        // at the min duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }

                    } onPressingChanged: { isPressing in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration:1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }


                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
    }
}

#Preview {
    LongPressedGestureDemo()
}

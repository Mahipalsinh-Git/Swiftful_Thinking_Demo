//
//  25_CustomCombine.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/18/24.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {

    @Published var count: Int = 1
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()

    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false

    @Published var showButton: Bool = false

    init() {
        setupTimer()
        addTextFieldSubscriber()
        buttonSubscriber()
    }

    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { value in
                if value.count > 3 {
                    return true
                }
                return false
            }
        //            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: {[weak self] value in
                guard let self = self else { return }
                self.textIsValid = value
            })
            .store(in: &cancellables)
    }

    func setupTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] output in
                guard let self = self else { return }
                self.count += 1

                //                if self.count >= 5 {
                ////                    self.timer?.cancel() // Single cancellable
                //
                //                    for item in self.cancellables {
                //                        item.cancel()
                //                    }
                //                }
            }
            .store(in: &cancellables)
    }

    func buttonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }

                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct CustomCombineDemo: View {

    @StateObject var vm = SubscriberViewModel()

    var body: some View {

        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)

            Text("is valid: \(vm.textIsValid)")

            TextField("Enter value", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                    vm.textIsValid ? 0.0 : 1.0
                            )

                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(
                                    vm.textIsValid ? 1.0 : 0.0
                            )
                    }
                    .font(.title)
                    .padding(.trailing)
                }

            Button {

            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
        }
        .padding()
    }
}

#Preview {
    CustomCombineDemo()
}

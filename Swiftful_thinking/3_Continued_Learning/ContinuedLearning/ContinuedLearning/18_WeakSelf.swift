//
//  18_WeakSelf.swift
//  ContinuedLearning
//
//  Created by Mahipal on 08/10/24.
//

import SwiftUI

struct WeakSelfDemo: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.clipShape(RoundedRectangle(cornerRadius: 10))),
            alignment: .topTrailing
        )
    }
}

class WeakSelfSecondViewModel : ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("Init")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    func getData() {
//        DispatchQueue.global().async {
//            self.data = "Hello, World!"
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 25) { [weak self] in
            self?.data = "Hello, World!"
        }
    }
    
    deinit {
        print("Deinit")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
                    .font(.title)
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    WeakSelfDemo()
}

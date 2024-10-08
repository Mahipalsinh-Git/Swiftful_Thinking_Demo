//
//  17_BackgroundThread.swift
//  ContinuedLearning
//
//  Created by Mahipal on 08/10/24.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    init() {
        
    }
    
    func fetchData() {
        // Way - 1
        /*
        DispatchQueue.global().async {
            let newData = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
        */
        
        // Way - 2 : Proper working
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<1000000 {
            data.append("\(x)")
        }
        
        return data
    }
}

struct BackgroundThreadDemo: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load data...")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadDemo()
}

//
//  20_Escaping.swift
//  ContinuedLearning
//
//  Created by Mahipal on 09/10/24.
//

import SwiftUI

class EscapingViewModel : ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        //        let newData = downloadData()
        //        text = newData
        
        //        downloadDataFromServer2 { [weak self] data in
        //            self?.text = data
        //        }
        
        //        downloadDataFromServer3 { [weak self] result in
        //            self?.text = result.data
        //        }
        
        downloadDataFromServer4 { [weak self] result in
            self?.text = result.data
        }
    }
    
    private func downloadData() -> String {
        return "New data"
    }
    
    private func downloadDataFromServer(completionHandler: (_ data: String) -> Void) {
        completionHandler("New data")
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
        //            return "New data"
        //        }
    }
    
    private func downloadDataFromServer2(
        completionHandler: @escaping (_ data: String) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            completionHandler("New data")
        }
    }
    
    private func downloadDataFromServer3(
        completionHandler: @escaping (DownloadResult) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let result = DownloadResult(data: "New data")
            completionHandler(result)
        }
    }
    
    private func downloadDataFromServer4(
        completionHandler: @escaping DownloadCompletion
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let result = DownloadResult(data: "New data")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> Void

struct EscapingDemo: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingDemo()
}

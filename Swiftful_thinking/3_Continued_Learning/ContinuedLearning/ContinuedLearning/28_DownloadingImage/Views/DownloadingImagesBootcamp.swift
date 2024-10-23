//
//  DownloadingImagesBootcamp.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/22/24.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {

    @StateObject var vm = DownloadingImageViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Image Caches")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}

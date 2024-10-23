//
//  DownloadingImageView.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/22/24.
//

import SwiftUI

struct DownloadingImageView: View {

    @StateObject var vm: ImageLoadingViewModel

    init(imageUrl: String, key: String) {
        _vm = StateObject(wrappedValue: ImageLoadingViewModel(url: imageUrl, key: key))
    }

    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    DownloadingImageView(imageUrl: "https://via.placeholder.com/600/92c952", key: "1")
}

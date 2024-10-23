//
//  DownloadingImagesRow.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/22/24.
//

import SwiftUI

struct DownloadingImagesRow: View {

    let model: PhotoModel

    var body: some View {
        HStack(alignment: .top) {
            DownloadingImageView(imageUrl: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)

            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)

                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadingImagesRow(model: PhotoModel(albumId: 1,
                                           id: 2,
                                           title: "Hello",
                                           url: "https://via.placeholder.com/600/92c952",
                                           thumbnailUrl: "https://via.placeholder.com/600/92c952"))
    .padding()
//    .previewLayout(.sizeThatFits)

}

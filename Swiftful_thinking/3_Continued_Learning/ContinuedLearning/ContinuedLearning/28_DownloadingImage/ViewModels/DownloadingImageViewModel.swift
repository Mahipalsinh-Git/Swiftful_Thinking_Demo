//
//  DownloadingImageViewModel.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/22/24.
//

import Foundation
import Combine

class DownloadingImageViewModel: ObservableObject {

    @Published var dataArray: [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    var cancellable = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModel in
                self?.dataArray = returnedPhotoModel
            }
            .store(in: &cancellable)
    }
}

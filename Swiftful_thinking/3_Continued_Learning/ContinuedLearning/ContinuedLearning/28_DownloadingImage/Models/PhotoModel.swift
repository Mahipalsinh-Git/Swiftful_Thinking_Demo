//
//  PhotoModel.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/22/24.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

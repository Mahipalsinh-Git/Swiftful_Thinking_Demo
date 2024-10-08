//
//  19_TypeAlias.swift
//  ContinuedLearning
//
//  Created by Mahipal on 08/10/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TvModel = MovieModel

struct TypeAliasDemo: View {
    
    @State var items: MovieModel = MovieModel(title: "hello", director: "world", count: 5)
    @State var tvItems: TvModel = TvModel(title: "TV hello", director: "TV world", count: 15)
    
    var body: some View {
        VStack {
            Text(items.title)
            Text(items.director)
            Text("\(items.count)")
            
            Divider()
            
            Text(tvItems.title)
            Text(tvItems.director)
            Text("\(tvItems.count)")
        }
    }
}

#Preview {
    TypeAliasDemo()
}

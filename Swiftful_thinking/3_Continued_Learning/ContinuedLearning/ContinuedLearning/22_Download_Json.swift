//
//  22_Download_Json.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/17/24.
//

import SwiftUI

struct PostModel:  Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {

    @Published var posts: [PostModel] = []

    init() {
        getData()
    }

    func getData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") else { return }

        downloadData(fromURL: url) { getData in
            if let data = getData {

                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return
                }

                DispatchQueue.main.async { [weak self] in
//                    self?.posts.append(newPost)
                    self?.posts = newPosts
                }
            } else {
                print("Something went wrong!")
            }
        }
    }

    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("No Data.")

                completionHandler(nil)

                return
            }

            completionHandler(data)

        }.resume()
    }
}

struct DownloadJsonDemo: View {

    @StateObject var vm = DownloadWithEscapingViewModel()

    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)

                    Spacer()
                        .frame(height: 15)

                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    DownloadJsonDemo()
}

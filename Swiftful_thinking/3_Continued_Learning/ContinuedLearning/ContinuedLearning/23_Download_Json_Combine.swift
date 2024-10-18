//
//  23_Download_Json_Combine.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/18/24.
//

import SwiftUI
import Combine

struct PostDataModel:  Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostDataModel] = []

    var cancellables = Set<AnyCancellable>()

    init() {
        getData()
    }

    func getData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") else { return }

        // Combine Discussion:
        /*
         // 1. sign up for monthly subscription for package to be delivered
         // 2. the company would make the package behind the scene
         // 3. recieve the package at your front door
         // 4. make sure the box isn't damaged
         // 5. open and make sure the item is correct
         // 6. use the item!!
         // 7. cancellable at any time

         // 1. create the publisher
         // 2. subscribe publisher on background thread
         // 3. recieve on main thread
         // 4. tryMap (check that the data is good)
         // 5. decode (decode data into PostModels)
         // 6. sink (put the item into our app)
         // 7. store (cancel subscription if needed)
         */

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main) // Receive on main thread
        /*
         .tryMap { (data, response) -> Data in
         guard
         let response = response as? HTTPURLResponse,
         response.statusCode >= 200 && response.statusCode < 300 else {
         throw URLError(.badServerResponse)
         }
         return data
         }
         */
            .tryMap(handleOutput) // for general output
            .decode(type: [PostDataModel].self, decoder: JSONDecoder())
        //            .replaceError(with: [])
            .sink { (completion) in
                print("Completion: \(completion)")
                switch completion {
                    case .finished  :
                        print("Finished")
                    case .failure(let error) :
                        print("Error: \(error.localizedDescription)")
                }

            } receiveValue: { [weak self]  (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }

    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadJsonCombineDemo: View {

    @StateObject var vm = DownloadWithCombineViewModel()

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
    DownloadJsonCombineDemo()
}

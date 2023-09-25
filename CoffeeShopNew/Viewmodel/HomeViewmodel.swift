//
//  HomeViewmodel.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 19.09.2023.
//

import Foundation

class HomeViewmodel {
    
    let baseUrl = "https://pixabay.com/api/"
    private var currentPage = 1
    private let itemsPerPage = 10
    private var isFetching = false // İstek yapılıyor mu kontrolü
    var dataArray: [FeedData] = []

    func fetchData(with query: String, page: Int, per_page: Int, completion: @escaping ([FeedData]) -> Void) {
        let apiKey = "37427312-d8d1e5548011abcd225706ea7"
        if let url = URL(string: "\(baseUrl)?key=\(apiKey)&q=\(query)&page=\(page)&per_page=\(per_page)") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    completion([])
                    return
                }
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let fetchData = json["hits"] as? [[String: Any]] {
                                var dataArray: [FeedData] = []
                                for data in fetchData {
                                    if let id = data["id"] as? Int,
                                       let previewURL = data["previewURL"] as? String {
                                        let responseData = FeedData(id: id, previewURL: previewURL)
                                        dataArray.append(responseData)
                                    }
                                }
                                completion(dataArray)
                            }
                        } else {
                            print("else'deki error")
                            completion([])
                        }
                    } catch {
                        print("JSON verisi çözümlenemedi: \(error)")
                        completion([])
                    }
                }
            }
            task.resume()
        }
    }

    
    func fetchNextPage(with query: String, completion: @escaping ([FeedData]) -> Void) {
            // Pagination sırasında aynı sayfayı birden fazla kez çağırmamak için kontrol ekleyin
            guard !isFetching else { return }
            isFetching = true

            fetchData(with: query, page: currentPage, per_page: itemsPerPage) { [weak self] (newData) in
                // Yeni verileri alındıktan sonra mevcut verilere ekleyin
                self?.dataArray += newData
                self?.currentPage += 1
                self?.isFetching = false
                completion(newData)
            }
        }
    
}

//
//  CategoryViewmodel.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 22.09.2023.
//

import Foundation

class CategoryViewmodel {
 
    let baseUrl = "https://pixabay.com/api/"

    func fetchData(with categories: [String], completion: @escaping ([CategoryData]) -> Void) {
        let apiKey = "37427312-d8d1e5548011abcd225706ea7"
        for category in categories {
            if let url = URL(string: "\(baseUrl)?key=\(apiKey)&category=\(category)") {
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
                                    var dataArray: [CategoryData] = []
                                    for data in fetchData {
                                        if let id = data["id"] as? Int,
                                           let previewURL = data["previewURL"] as? String,
                                           let tags = data["tags"] as? String {
                                            let tagsArray = tags.components(separatedBy: ",")
                                            let responseData = CategoryData(id: id, previewURL: previewURL, tag: tagsArray.first ?? "DENEME")
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
    }
    
}


/*
 //
 //  CategoryViewmodel.swift
 //  CoffeeShopNew
 //
 //  Created by Mehmet Gül on 22.09.2023.
 //

 import Foundation

 class CategoryViewmodel {
  
     let baseUrl = "https://pixabay.com/api/"

     func fetchData(with categories: [String], completion: @escaping ([CategoryData]) -> Void) {
         let apiKey = "37427312-d8d1e5548011abcd225706ea7"
         for category in categories {
             if let url = URL(string: "\(baseUrl)?key=\(apiKey)&category=\(category)") {
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
                                     var dataArray: [CategoryData] = []
                                     for data in fetchData {
                                         if let id = data["id"] as? Int,
                                            let previewURL = data["previewURL"] as? String,
                                            let tags = data["tags"] as? String{
                                                 let responseData = CategoryData(id: id, previewURL: previewURL, tags: [tags])
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
     }
     
 }

 */

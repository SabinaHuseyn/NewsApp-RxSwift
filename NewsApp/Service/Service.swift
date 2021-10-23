//
//  Service.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import Foundation
import Alamofire
import RxSwift

class Service {

    static let shared = Service()
 
    func fetchNewsForPickerView(completion: @escaping ([NewsFilterModel]?, Error?) -> ()) {
        let urlString = "\(API.baseUrl1)?apiKey=\(API.apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch news:", err)
                return
            }
            // check response
            guard let data = data else { return }
            do {
                let news = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    let newsList = news.sources
                    completion(newsList, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
    
    func fetchNewsForTableview(query: [URLQueryItem], completion: @escaping ([ArticleModel]) -> Void) {
        // 1
        let url = API.baseUrl
        // 2
        var components = URLComponents(string: url)!
        components.queryItems = query

        AF.request(components.url! as URLConvertible, method: .get).responseDecodable(
        of: ResponseArticle.self) { response in
            print("DATA\(response)")
            guard let items = response.value else {
                return completion([])

          }
            DispatchQueue.main.async {
                completion(items.articles)
                print("RESULT\(items.articles)")
            }
        }
    }

    func fetchSearch(query: String, completion: @escaping ([ArticleModel]) -> Void) {
      // 1
        let url = API.baseUrl
      // 2
        var components = URLComponents(string: url)!
       
        AF.request(components.url! as URLConvertible, method: .get).responseDecodable(
        of: ResponseArticle.self) { response in
            print("DATA\(response)")
            guard let items = response.value else {
            return completion([])
          }
            DispatchQueue.main.async {
                completion(items.articles)
                print("RESULT\(items.articles)")
            }
        }
    }}


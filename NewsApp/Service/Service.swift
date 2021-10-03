//
//  Service.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import Foundation
import Alamofire
    

class Service {
    
//    enum Query {
//        case countryQ
//        case categoryQ
//        case publishedAtQ
//        case sourceQ
//        case searchingQ
//        case everythingQ
//    }
    static let shared = Service()
    
//    func queryItems(dictionary: [String:String]) -> [URLQueryItem] {
//        return dictionary.map {
//            URLQueryItem(name: $0, value: $1)
//        }
//    }
    
    func fetchNews(completion: @escaping ([NewsFilterModel]?, Error?) -> ()) {
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
    
    func fetchNewsCountry(query: String, page: Int = 1, completion: @escaping ([ArticleModel]) -> Void) {
        // 1
        let url = API.baseUrl
        // 2
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "country", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]

        AF.request(components.url! as! URLConvertible, method: .get).responseDecodable(
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

    func fetchNewsSource(query: String, completion: @escaping ([ArticleModel]) -> Void) {
      // 1
        let url = API.baseUrl
      // 2
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "sources", value: query),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]

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
    
    func fetchNewsCategory(query: String, completion: @escaping ([ArticleModel]) -> Void) {
      // 1
        let url = API.baseUrl
      // 2
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "category", value: query),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]

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
    
    func fetchNewsDate(query: String, completion: @escaping ([ArticleModel]) -> Void) {
      // 1
        let url = API.baseUrl
      // 2
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "from", value: query),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]

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
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]

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


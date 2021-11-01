//
//  Service.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    func fetchNewsForPickerView(completion: @escaping ([NewsFilterModel]) -> Void) {
        // 1
        let url = API.baseUrl1
        // 2
        var components = URLComponents(string: url)!
        let query: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: API.apiKey)
        ]
        components.queryItems = query
        
        AF.request(components.url! as URLConvertible, method: .get).responseDecodable(
            of: Response.self) { response in
                guard let items = response.value else {
                    return completion([])
                    
                }
                DispatchQueue.main.async {
                    completion(items.sources)
                }
            }
    }
    
    func fetchNewsForTableview(query: [URLQueryItem], completion: @escaping ([ArticleModel]) -> Void) {
        // 1
        let url = API.baseUrl
        // 2let
        var components = URLComponents(string: url)!
        components.queryItems = query
        
        AF.request(components.url! as URLConvertible, method: .get).responseDecodable(
            of: ResponseArticle.self) { response in
                guard let items = response.value else {
                    return completion([])
                    
                }
                DispatchQueue.main.async {
                    completion(items.articles)
                }
            }
    }
    
}

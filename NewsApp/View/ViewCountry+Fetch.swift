//
//  ViewCountry+Fetch.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 27.09.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension ViewController {

     func fetchCountry(country: String) {
         articlePicked = true
         searchbarSearched = false
         let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]
         Service.shared.fetchNewsForTableview(query: queryParams) { news in
                 DispatchQueue.main.async {
                    var array = self.articlesViewModels.value
                    array.removeAll()
                    let newArray = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
                    self.articlesViewModels.accept(newArray)
            }

        }
    }
    
    func fetchSource(source: String) {
        articlePicked = true
        searchbarSearched = false
        let queryParams: [URLQueryItem] = [
           URLQueryItem(name: "sources", value: source),
           URLQueryItem(name: "apiKey", value: API.apiKey),
       ]
       Service.shared.fetchNewsForTableview(query: queryParams) { news in
               DispatchQueue.main.async {
                   var array = self.articlesViewModels.value
                   array.removeAll()
                   let newArray = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
                   self.articlesViewModels.accept(newArray)
               }
       }
   }
    
    func fetchCategory(category: String) {
        articlePicked = true
        searchbarSearched = false
        let queryParams: [URLQueryItem] = [
           URLQueryItem(name: "category", value: category),
           URLQueryItem(name: "apiKey", value: API.apiKey),
       ]
       Service.shared.fetchNewsForTableview(query: queryParams) { news in
           DispatchQueue.main.async {
               var array = self.articlesViewModels.value
               array.removeAll()
               let newArray = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
               self.articlesViewModels.accept(newArray)
           }
   }
}
    
}


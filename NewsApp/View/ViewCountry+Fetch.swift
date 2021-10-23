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
    
    func observableFetch(query: [URLQueryItem]) {
        ObservableViewModel.shared.fetchNews(query: query)
     .observe(on: MainScheduler.instance)
     .subscribe(onNext: { data in
         var array = self.articlesViewModels.value
         array.removeAll()
       self.articlesViewModels.accept(data)
     })
     .disposed(by: disposeBag)
    }

     func fetchCountry(country: String) {
         articlePicked = true
         searchbarSearched = false
         let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "apiKey", value: API.apiKey),
         ]
         
         observableFetch(query: queryParams)
    }
    
    func fetchSource(source: String) {
        articlePicked = true
        searchbarSearched = false
        let queryParams: [URLQueryItem] = [
           URLQueryItem(name: "sources", value: source),
           URLQueryItem(name: "apiKey", value: API.apiKey),
       ]
        
        observableFetch(query: queryParams)
   }
    
    func fetchCategory(category: String) {
        articlePicked = true
        searchbarSearched = false
        let queryParams: [URLQueryItem] = [
           URLQueryItem(name: "category", value: category),
           URLQueryItem(name: "apiKey", value: API.apiKey),
       ]
        
        observableFetch(query: queryParams)
    }
    
    func textSearchChange(_ sender: String) {
        articlePicked = false
        searchbarSearched = true
        let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "q", value: sender),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]
        
        observableFetch(query: queryParams)
        }
}


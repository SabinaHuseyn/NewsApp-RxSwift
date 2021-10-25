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
    
    func filterNews() {
        ObservableNewsViewModel.shared.fetchNewsForPicker()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                let countryArray = data.map({return $0.country})
                let categoryArray = data.map({return $0.category})
                let sourceArray = data.map({return $0.name})
                self.newsCountry.accept(countryArray)
                self.newsCategory.accept(categoryArray)
                self.newsSource.accept(sourceArray)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchCountry(country: String) {
        let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]
        observableFetch(query: queryParams)
    }
    
    func fetchSource(source: String) {
        let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "sources", value: source),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]
        observableFetch(query: queryParams)
    }
    
    func fetchCategory(category: String) {
        let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]
        observableFetch(query: queryParams)
    }
    
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
}


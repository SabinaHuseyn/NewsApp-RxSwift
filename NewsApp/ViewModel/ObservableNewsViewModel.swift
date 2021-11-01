//
//  NewsFilterViewModel.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 25.09.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ObservableNewsViewModel{
    
    static let shared = ObservableNewsViewModel()
    var observableViewModel = ObservableViewModel()

//    public var newsCountry = BehaviorRelay<[String]>(value: [])
//    public var newsCategory = BehaviorRelay<[String]>(value: [])
//    public var newsSource = BehaviorRelay<[String]>(value: [])
    public var articlesViewModels = BehaviorRelay<[ObservableViewModel.ArticlesFilterViewModel]>(value: [])

    let disposeBag = DisposeBag()

    struct NewsFilterViewModel: Hashable {
        
        let country: String
        let id, name, description, category, url, language: String
        
        init(newsFilterModel: NewsFilterModel) {
            self.country = newsFilterModel.country!
            self.id = newsFilterModel.id!
            self.name = newsFilterModel.name!
            self.description = newsFilterModel.description!
            self.category = newsFilterModel.category!
            self.url = newsFilterModel.url!
            self.language = newsFilterModel.language!
            //    print("VIEW MODEL:\(self.country)")
        }
    }
    
    func fetchNewsForPicker() -> Observable<[NewsFilterViewModel]> {
        return Observable.create { observer in
            Service.shared.fetchNewsForPickerView(){ result in
                let newArray = result.map({return NewsFilterViewModel(newsFilterModel: $0)})
                observer.onNext(newArray)
                observer.onCompleted()
            }
            return Disposables.create()
        }
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

//
//  ArticlesFilterViewModel.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.09.21.
//

import Foundation
import UIKit
import RxSwift
        
class ObservableViewModel{
    
    static let shared = ObservableViewModel()
    
    struct ArticlesFilterViewModel {
        
        var id: String?
        var name: String?
        var author, title, description, urlToImage, url, publishedAt, content: String?
        
        init(articlesFilterModel: ArticleModel) {
            
            if let articId = articlesFilterModel.source?.id {
                self.id = articId
            }
            if let articSource = articlesFilterModel.source {
                if let articSourceName = articSource.name {
                    self.name = articSourceName
                }
            }
            if let articAuthor = articlesFilterModel.author {
                self.author = articAuthor
            }
            if let articTitle = articlesFilterModel.title {
                self.title = articTitle
            }
            if let articDescription = articlesFilterModel.description {
                self.description = articDescription
            }
            if let articUrlToImage = articlesFilterModel.urlToImage {
                self.urlToImage = articUrlToImage
            }
            if let articUrl = articlesFilterModel.url {
                self.url = articUrl
            }
            if let articPublishedAt = articlesFilterModel.publishedAt {
                self.publishedAt = articPublishedAt
            }
            
            if let articContent = articlesFilterModel.content {
                self.content = articContent
            }
            
        }
    }
    
    func observableFetch(query: [URLQueryItem]) -> Observable<[ArticlesFilterViewModel]> {
        return Observable.create { observer in
            Service.shared.fetchNewsForTableview(query: query){ result in
                let newArray = result.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
                observer.onNext(newArray)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func fetchNews(query: [URLQueryItem]) -> Observable<[ArticlesFilterViewModel]> {
        return observableFetch(query: query)
    }
    
    func textSearchChange(_ sender: String) -> Observable<[ArticlesFilterViewModel]> {
        let queryParams: [URLQueryItem] = [
            URLQueryItem(name: "q", value: sender),
            URLQueryItem(name: "apiKey", value: API.apiKey),
        ]
       return observableFetch(query: queryParams)
        }
    
}

        


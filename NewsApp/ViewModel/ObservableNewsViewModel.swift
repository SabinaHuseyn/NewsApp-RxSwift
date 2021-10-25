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
//    static let countryObservable = Observable<[NewsFilterViewModel]>
//    static let categoryObservable = Observable<[NewsFilterViewModel]>
//    static let sourcesObservable = Observable<[NewsFilterViewModel]>

    
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
}

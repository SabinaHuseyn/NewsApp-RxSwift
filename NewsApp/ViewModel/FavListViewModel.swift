//
//  FavListViewModel.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.10.21.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class FavListViewModel{
    
    static let shared = FavListViewModel()

    public var savedNews = BehaviorRelay<[WishList]>(value: [])
    let disposeBag = DisposeBag()
    let persistenceManager = PersistenceManager.shared
    
    func setupFavs() {
        getSavedFavToObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
//                var array = self.savedNews.value
//                array.removeAll()
                self.savedNews.accept(data)
            })
            .disposed(by: disposeBag)
    }
    
    func getSavedFavToObservable() -> Observable<[WishList]>{
        return Observable.create { observer in
            let result = self.persistenceManager.fetch(WishList.self)
            let newArray = result.map({return $0})
            observer.onNext(newArray)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

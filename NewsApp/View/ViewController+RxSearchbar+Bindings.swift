////
////  ViewController+RxSearchbar+Bindings.swift
////  NewsApp
////
////  Created by Sabina Huseynova on 01.11.21.
////
//
//import Foundation
//import UIKit
//import RxSwift
//import RxCocoa
//
//extension ViewController {
//    
//    func setupSearching() {
//        searchBar
//            .rx.text.orEmpty
//            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .flatMapLatest { query -> Observable<[ObservableViewModel.ArticlesFilterViewModel]> in
//                if query.isEmpty {
//                    return .just([])
//                }
//                return ObservableViewModel.shared.textSearchChange(query)
//            }
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { data in
//                var array = self.articlesViewModels.value
//                array.removeAll()
//                self.articlesViewModels.accept(data)
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    func setupBindings() {
//        observableNewsViewModel
//            .articlesViewModels
//            .observe(on: MainScheduler.instance)
//            .bind(to: self.articlesViewModels)
//            .disposed(by: disposeBag)
//        
//        favListViewModel
//            .savedNews
//            .observe(on: MainScheduler.instance)
//            .bind(to: self.savedNews)
//            .disposed(by: disposeBag)
//    }
//    func filterNews() {
//        observableNewsViewModel.fetchNewsForPicker()
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { data in
//                let countryArray = data.map({return $0.country})
//                let categoryArray = data.map({return $0.category})
//                let sourceArray = data.map({return $0.name})
//                self.newsCountry.accept(countryArray)
//                self.newsCategory.accept(categoryArray)
//                self.newsSource.accept(sourceArray)
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    func badgeCountChange() {
//        FavListViewModel.shared.savedNews.asObservable()
//            .subscribe(onNext: { [unowned self] news in
//                if news.count == 0 {
//                    self.badgeCount.isHidden = true
//                }else {
//                    self.badgeCount.text = "\(news.count)"
//                    self.badgeCount.isHidden = false
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//}

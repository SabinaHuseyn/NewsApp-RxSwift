//
//  ViewController+UIPickerView.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension ViewController {
    
    func setupCountryPickerViews() {
        let filteredNews = newsCountry.asObservable().map { Array(Set($0)) }

        filteredNews
            .observe(on: MainScheduler.instance)
            .bind(to: countryPickerView
                    .rx
                    .itemAttributedTitles) { (row, element) in
                return NSAttributedString(string: element)
            }
        .disposed(by: disposeBag)
    }
    
    func setupCountryPickerTapHandling() {
        countryPickerView.rx.itemSelected
            .subscribe(onNext: { [weak self] (row, element) in
                guard let wSelf = self else {
                    return
                }
                self?.fetchCountry(country: wSelf.newsCountry.value[row])
                self?.btnCountry.setTitle(wSelf.newsCountry.value[row], for: .normal)
                self?.btnCategory.setTitle("Category", for: .normal)
                self?.btnSource.setTitle("Source", for: .normal)
                self?.countryPickerView.isHidden = true
                
            }).disposed(by: disposeBag)
    }

func setupCategoryPickerViews() {
    let filteredNews = newsCategory.asObservable().map { Array(Set($0)) }

    filteredNews
        .observe(on: MainScheduler.instance)
        .bind(to: categoryPickerView
                .rx
                .itemAttributedTitles) { (row, element) in
            return NSAttributedString(string: element)
        }
    .disposed(by: disposeBag)
}

func setupCategoryPickerTapHandling() {
    categoryPickerView.rx.itemSelected
        .subscribe(onNext: { [weak self] (row, element) in
            guard let wSelf = self else {
                return
            }
            self?.fetchCategory(category: wSelf.newsCategory.value[row])
            self?.btnCategory.setTitle(wSelf.newsCategory.value[row], for: .normal)
            self?.btnCountry.setTitle("Country", for: .normal)
            self?.btnSource.setTitle("Source", for: .normal)
            self?.categoryPickerView.isHidden = true
            
        }).disposed(by: disposeBag)
}

func setupSourcePickerViews() {
    let filteredNews = newsSource.asObservable().map { Array(Set($0)) }

    filteredNews
        .observe(on: MainScheduler.instance)
        .bind(to: sourcePickerView
                .rx
                .itemAttributedTitles) { (row, element) in
            return NSAttributedString(string: element)
        }
    .disposed(by: disposeBag)
}

func setupSourcePickerTapHandling() {
    sourcePickerView.rx.itemSelected
        .subscribe(onNext: { [weak self] (row, element) in
            guard let wSelf = self else {
                return
            }
            self?.fetchSource(source:wSelf.newsSource.value[row])
            self?.btnSource.setTitle(wSelf.newsSource.value[row], for: .normal)
            self?.btnCountry.setTitle("Country", for: .normal)
            self?.btnCategory.setTitle("Category", for: .normal)
            self?.sourcePickerView.isHidden = true
            
        }).disposed(by: disposeBag)
}
}

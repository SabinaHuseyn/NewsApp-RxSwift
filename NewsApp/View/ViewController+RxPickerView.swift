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
        newsCountry.asObservable().map { Array(Set($0)) }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { data in
            self.filteredCountry.accept(data)
        })
        .disposed(by: disposeBag)
        
        filteredCountry
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
                self?.observableNewsViewModel.fetchCountry(country: wSelf.filteredCountry.value[row])
                self?.btnCountry.setTitle(wSelf.filteredCountry.value[row], for: .normal)
                self?.btnCountry.setImage(nil, for: .normal)
                self?.btnCountry.contentHorizontalAlignment = .center
                self?.btnCategory.setBtn("Category")
                self?.btnSource.setBtn("Source")
                self?.countryPickerView.isHidden = true
                
            }).disposed(by: disposeBag)
    }
    
    func setupCategoryPickerViews() {
        newsCategory.map { Array(Set($0)) }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { data in
            self.filteredCategory.accept(data)
        })
        .disposed(by: disposeBag)
        
        filteredCategory
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
                self?.observableNewsViewModel.fetchCategory(category: wSelf.filteredCategory.value[row])
                self?.btnCategory.setTitle(wSelf.filteredCategory.value[row], for: .normal)
                self?.btnCategory.setImage(nil, for: .normal)
                self?.btnCategory.contentHorizontalAlignment = .center
                self?.btnCountry.setBtn("Country")
                self?.btnSource.setBtn("Source")
                self?.categoryPickerView.isHidden = true
                
            }).disposed(by: disposeBag)
    }
    
    func setupSourcePickerViews() {
        newsSource.asObservable().map { Array(Set($0)) }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { data in
            self.filteredSource.accept(data)
        })
        .disposed(by: disposeBag)
        
        filteredSource
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
                self?.observableNewsViewModel.fetchSource(source:wSelf.filteredSource.value[row])
                self?.btnSource.setTitle(wSelf.filteredSource.value[row], for: .normal)
                self?.btnSource.setImage(nil, for: .normal)
                self?.btnSource.contentHorizontalAlignment = .center
                self?.btnCountry.setBtn("Country")
                self?.btnCategory.setBtn("Category")
                self?.sourcePickerView.isHidden = true
                
            }).disposed(by: disposeBag)
    }
}

//
//  ViewController+RxTableView.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.10.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension ViewController {
    
    func setupMainCell() {
        articlesViewModels
            .observe(on: MainScheduler.instance)
            .bind(to: mainTableView
                    .rx
                    .items(cellIdentifier: "MainTableViewCell",
                           cellType: MainTableViewCell.self)) { row, article, cell in
                cell.populateCell(articlesFilterViewModel: article)
                if let img = article.urlToImage {
                    if let cellUrl = URL(string: img) {
                        cell.articleImg.af.setImage(withURL: cellUrl)
                    }
                }
                let newsTitle = article.title
                if cell.checkCoreDataForExistingWish(newsTitle!) {
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "filledFav"), for: .normal)
                } else {
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "emptyFav"), for: .normal)
                }
            }
                           .disposed(by: disposeBag)
    }
    
    func setupCellTapHandling() {
        mainTableView.rx.modelSelected(ObservableViewModel.ArticlesFilterViewModel.self)
            .map{ $0.url }
            .subscribe(onNext: { [weak self] url in
                guard let url = url else {
                    return
                }
                self?.mainCoordinator?.detailShow(url)
            }).disposed(by: disposeBag)
    }
}

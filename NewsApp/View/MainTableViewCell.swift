//
//  MainTableViewCell.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.09.21.
//

import UIKit
import AlamofireImage
import CoreData
import RxSwift
import RxCocoa


class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var container: NSPersistentContainer!
    let persistenceManager = PersistenceManager.shared
    var title: String?
    var articlesFilterViewModel: ObservableViewModel.ArticlesFilterViewModel!
    var favListViewModel = FavListViewModel()
    var disposeBag = DisposeBag()
    var favNews: [WishList]?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.articleImg.af.cancelImageRequest()
        self.articleImg.image = nil
        disposeBag = DisposeBag()
        
    }
    
    func populateCell(articlesFilterViewModel: ObservableViewModel.ArticlesFilterViewModel) {
        guard let artName = articlesFilterViewModel.name else {return}
        self.sourceLbl?.text = artName
        guard let artAuthor = articlesFilterViewModel.author else {return}
        self.authorLbl?.text = artAuthor
        guard let artDescription = articlesFilterViewModel.description else {return}
        self.descriptionLbl?.text = artDescription
        guard let newtitle = articlesFilterViewModel.title else {return}
        self.title = newtitle
        self.titleLbl?.text = newtitle
        self.articlesFilterViewModel = articlesFilterViewModel
        print("ETO TITLE\(String(describing: self.title))")
    }
    
    func populateFav(favNews: WishList) {
        guard let artName = favNews.name else {return}
        self.sourceLbl?.text = artName
        guard let artAuthor = favNews.author else {return}
        self.authorLbl?.text = artAuthor
        let artDescription = favNews.description
        self.descriptionLbl?.text = artDescription
        guard let newtitle = favNews.title else {return}
        self.title = newtitle
        self.titleLbl?.text = newtitle
        //        self.favNews = favNews
        print("ETO TITLE\(String(describing: self.title))")
    }
    
    @IBAction func clickLike(_ sender: UIButton) {
        saveWishToFavorites()
        let newValue = self.persistenceManager.fetch(WishList.self)
        FavListViewModel.shared.savedNews.accept(newValue)
//        self.likeBtn.rx.tap
//            .debug("button tap")
//            .bind(onNext: { [unowned self] _ in
//            }).disposed(by: disposeBag)
    }
}
        //       let vc  = ViewController()
        //        vc.setupFavs()
        //        let favVc = FavListViewController()
        //        vc.setupFavs()
        //        Observable.create { observer in
        //            persistenceManager.fetch(WishList.self){ result in
        ////                let newArray = result.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
        //                observer.onNext(newArray)
        //                observer.onComp
        //        favNews =
        
        //                let newValue =  FavListViewModel.shared.savedNews.value + [article]
        
        
        //            if let news = strongself.favNews {
        //                vc.savedNews.accept(news)
        //                vc.badgeCount.text = "\(news.count)"
        //                favVc.savedNews.accept(news)
        //            }

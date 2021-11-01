//
//  WishListViewController.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class FavListViewController: UIViewController, NSFetchedResultsControllerDelegate {
    //        MARK: - VARIABLES
    var wishTableView: UITableView!
    var container: NSPersistentContainer!
    weak var coordinator: WishListCoordinator?
    let persistenceManager = PersistenceManager.shared
//    var savedFavArticles = BehaviorRelay<[WishList]>(value: [])
    var savedNews = BehaviorRelay<[WishList]>(value: [])
    let disposeBag = DisposeBag()
    var favListViewModel = FavListViewModel()
    var newsTitle: String?
    var wishAlreadySaved: Bool?
    var indexPath: IndexPath?
    var selectedItemId: String?
    weak var mainCoordinator: WishListCoordinator?
    var isLiked = Notification.Name("isLiked")
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var emptyLabel: UILabel = {
        let label = UILabel()
        label.setupLbl()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWishTableView()
        self.view.addSubview(emptyLabel)
        favListViewModel.setupFavs()
        setupMainCell()
        setupBindings()
        setupCellTapHandling()
        //        clearCoreDataStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().tintColor = .textBlue
            UINavigationBar.appearance().shadowImage = UIImage()
//            if self.savedFavArticles.value.count == 0 {
//                self.wishTableView.isHidden = true
//            }
            self.navigationItem.backButtonTitle = ""
        }
    }
    
//    func setupFavs() {
//        favListViewModel.getSavedFavToObservable()
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { data in
//                self.savedNews.accept(data)
//            })
//            .disposed(by: disposeBag)
//    }
    //  MARK: - SETUP UI
    func setupWishTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        wishTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        wishTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        wishTableView.separatorColor = .textBlue
        wishTableView.tintColor = .textBlue
        wishTableView.estimatedRowHeight = 200
        wishTableView.tableFooterView = UIView()
        self.view.addSubview(wishTableView)
        wishTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    //  MARK: - Setup Bindings
    
    func setupBindings() {

        FavListViewModel.shared.savedNews
            .observe(on: MainScheduler.instance)
            .bind(to: self.savedNews)
            .disposed(by: disposeBag)

    }
    
//    func setupFavs() {
//        favListViewModel.getSavedFavToObservable()
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { data in
//                var array = self.savedNews.value
//                array.removeAll()
//                self.savedNews.accept(data)
//            })
//            .disposed(by: disposeBag)
//    }
}

//MARK: - Rx Tableview
extension FavListViewController {
    
    func setupMainCell() {
        savedNews
            .observe(on: MainScheduler.instance)
            .bind(to: wishTableView
                    .rx
                    .items(cellIdentifier: "MainTableViewCell",
                           cellType: MainTableViewCell.self)) { row, article, cell in
                cell.populateFav(favNews: article)
                if let img = article.urlToImage {
                    if let cellUrl = URL(string: img) {
                        cell.articleImg.af.setImage(withURL: cellUrl)
                    }
                }
                if let newsTitle = article.title{
                if cell.checkCoreDataForExistingWish(newsTitle) {
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "filledFav"), for: .normal)
                } else {
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "emptyFav"), for: .normal)
                }
            }
            }
                           .disposed(by: disposeBag)
    }
    
    func setupCellTapHandling() {
        wishTableView.rx.modelSelected(WishList.self)
            .map{ $0.url }
            .subscribe(onNext: { [weak self] url in
                guard let url = url else {
                    return
                }
                self?.mainCoordinator?.detailShow(url)
            }).disposed(by: disposeBag)
    }
}

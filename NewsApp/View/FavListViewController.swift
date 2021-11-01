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
    
    var wishTableView: UITableView!
    var container: NSPersistentContainer!
    let persistenceManager = PersistenceManager.shared
    var savedNews = BehaviorRelay<[WishList]>(value: [])
    let disposeBag = DisposeBag()
    var favListViewModel = FavListViewModel()
    weak var mainCoordinator: WishListCoordinator?
    var newsTitle: String?
   
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
            self.navigationItem.backButtonTitle = ""
            self.fetchCoreData()

        }
    }
    
    func fetchCoreData() {
        let newValue = self.persistenceManager.fetch(WishList.self)
        self.savedNews.accept(newValue)
        
    }
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
}
//MARK: - Rx Tableview & Setup
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
    
    func setupBindings() {
        FavListViewModel.shared.savedNews
            .observe(on: MainScheduler.instance)
            .bind(to: self.savedNews)
            .disposed(by: disposeBag)
        
    }
}

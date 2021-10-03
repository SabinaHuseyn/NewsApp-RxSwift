//
//  WishListViewController.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import UIKit
import CoreData

class WishListViewController: UIViewController, NSFetchedResultsControllerDelegate, WishDelegate {
//        MARK: - VARIABLES
    var container: NSPersistentContainer!
    var fetchedResultsController: NSFetchedResultsController<WishList>!
    weak var coordinator: WishListCoordinator?
    let persistenceManager = PersistenceManager.shared
    var wishTableView: UITableView!
    var savedWishes: [WishList] = []
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
        wishTableView.tableFooterView = UIView()
        self.view.addSubview(emptyLabel)
        createObservers()
//        clearCoreDataStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().tintColor = .textBlue
            UINavigationBar.appearance().shadowImage = UIImage()

            self.savedWishes.removeAll()
            self.getSavedWishes()
            self.wishTableView.reloadData()
            if self.savedWishes.count == 0 {
                self.wishTableView.isHidden = true
            }
            if #available(iOS 11.0, *) {
                self.navigationItem.backButtonTitle = ""
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    func getSavedWishes(){
        let wishes = persistenceManager.fetch(WishList.self)
        self.savedWishes = wishes
        print(savedWishes)
    }
//  MARK: - SETUP FUNC
    func setupWishTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        wishTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        wishTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        wishTableView.dataSource = self
        wishTableView.delegate = self
        wishTableView.separatorColor = .textBlue
        wishTableView.tintColor = .textBlue
        wishTableView.estimatedRowHeight = 200
        wishTableView.tableFooterView = UIView()
        self.view.addSubview(wishTableView)
        wishTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    }

    //  MARK: - NotificationObservers
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(WishListViewController.updateTableView(notification:)), name: isLiked, object: nil)
    }
    
    @objc func updateTableView(notification: Notification) {
        if notification.name == isLiked {
            DispatchQueue.main.async {
                self.savedWishes.removeAll()
                self.getSavedWishes()
                self.wishTableView.reloadData()
            }
        }
        return
    }
    
}
//MARK: - Tableview
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(savedWishes.count)
        return savedWishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        if savedWishes.count == 0 {
            cell.isHidden = true
            self.wishTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return cell
            
        } else {
            self.emptyLabel.isHidden = true
            self.wishTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
         
            if let artName = savedWishes[indexPath.row].name {
                            cell.sourceLbl.text = artName
                        }

            if let artAuthor = savedWishes[indexPath.row].author {
                        cell.authorLbl.text = artAuthor
                }
            if let artTitle = savedWishes[indexPath.row].title {
                        cell.titleLbl.text = artTitle
                cell.title = artTitle

                }
            
            if let artDescription = savedWishes[indexPath.row].descriptionA {
                        cell.descriptionLbl.text = artDescription
                }
            
            if let img = savedWishes[indexPath.row].urlToImage {
                        if let cellUrl = URL(string: img) {
                            cell.articleImg.af.setImage(withURL: cellUrl)
                        }
                }
            
            newsTitle = savedWishes[indexPath.row].title
            if checkCoreDataForExistingWish(newsTitle!) {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "filledFav"), for: .normal)
            } else {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "emptyFav"), for: .normal)
            }            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailUrl = savedWishes[indexPath.row].url {
        coordinator?.detailShow(detailUrl)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
}

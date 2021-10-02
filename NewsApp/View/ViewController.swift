//
//  ViewController.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import UIKit
import AlamofireImage
import CoreData
//protocol GetList {
//    func getData(list: [NewsFilterViewModel])
//}

class ViewController: UIViewController, WishDelegate, Storyboarded {
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
    var newsFilterViewModels = [NewsFilterViewModel]()
    var articlesCountryViewModels = [ArticlesFilterViewModel]()
    var articlesCategoryViewModels = [ArticlesFilterViewModel]()
    var articlesSourcesViewModels = [ArticlesFilterViewModel]()
    var articlesDateViewModels = [ArticlesFilterViewModel]()
    var countrySearched = false
    var categorySearched = false
    var sourcesSearched = false
    var publishedDateSearched = false
    var searchbarSearched = false
//    var filteredWish: [ArticlesFilterViewModel] = []
    var savedTitles: [WishList] = []
    var mainTableView: UITableView!
    var countryPickerView = UIPickerView()
    var categoryPickerView = UIPickerView()
    var sourcePickerView = UIPickerView()
    var newsCountry = [NewsFilterViewModel]()
    var newsCategory = [NewsFilterViewModel]()
    var newsSource = [NewsFilterViewModel]()
    var spinner = UIActivityIndicatorView()
    let datePickerView = UIDatePicker()
    var container: NSPersistentContainer!
    let persistenceManager = PersistenceManager.shared
    weak var mainCoordinator: MainCoordinator?
    let favBtn = UIButton()
    var offset = UIOffset()
    var articlesSearchViewModels = [ArticlesFilterViewModel]() {
           didSet {
               mainTableView.reloadData()
           }
       }
    let searchController = UISearchController(searchResultsController: nil)
    var previousRun = Date()
    let minInterval = 0.05

    let badgeCount: UILabel = {
        var badge = UILabel()
        badge = UILabel(frame: CGRect(x: 22, y: -05, width: 20, height: 20))
        badge.badgeLbl()
        return badge
    }()
    
    let btnCountry: UIButton = {
        let button = UIButton()
        button.setBtn("Country")
        return button
    }()

    let btnCategory: UIButton = {
        let button = UIButton()
        button.setBtn("Category")
        return button

    }()

    let btnSource: UIButton = {
        let button = UIButton()
        button.setBtn("Source")
        return button

    }()
    
    let stackViewAll: UIStackView = {
        let stackView = UIStackView  ()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                                        #selector(handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
            return refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        UINavigationBar.appearance().tintColor = .textBlue
        view.addSubview(stackViewAll)
        view.backgroundColor = .white
        favBtn.addSubview(badgeCount)
        setupSearch()
        fetchData()
        getSavedWishes()
        setupStackView()
        setupBtn()
        setupMainTableView()
        setupCountryTableView()
        setupCategoryTableView()
        setupSourceTableView()
//        clearCoreDataStore()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
    self.navigationItem.leftBarButtonItem = leftNavBarButton
        let rightNavBarButton = UIBarButtonItem(customView:favBtn)
    self.navigationItem.rightBarButtonItem = rightNavBarButton
        DispatchQueue.main.async {
            self.getSavedWishes()
            self.mainTableView.reloadData()
            self.navigationItem.backButtonTitle = ""

        }
    }
    
    func fetchData() {
       Service.shared.fetchNews { (news, err) in
           if let err = err {
               print("Failed to fetch news:", err)
               return
           }
           self.newsFilterViewModels = news?.map({return NewsFilterViewModel(newsFilterModel: $0)}) ?? []
           DispatchQueue.main.async {
               self.filterSource()
               self.filterCountry()
               self.filterCategory()
               self.mainTableView.reloadData()
               self.countryPickerView.reloadAllComponents()
               self.categoryPickerView.reloadAllComponents()
               self.sourcePickerView.reloadAllComponents()
           }
       }
   }
    
//    func clearCoreDataStore() {
//            let context = persistenceManager.context
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
//    
//            let deleteReqest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//    
//            do {
//                try context.execute(deleteReqest)
//    
//            } catch {
//                print(error)
//            }
//        }
    
    func filterCountry() {
        var seen = Set<String>()
        for news in newsFilterViewModels {
            if !seen.contains(news.country) {
                newsCountry.append(news)
                seen.insert(news.country)
            }
        }
    }
    
    func filterCategory() {
        var seen = Set<String>()
        for news in newsFilterViewModels {
            if !seen.contains(news.category) {
                newsCategory.append(news)
                seen.insert(news.category)
            }
        }
    }
    func filterSource() {
        var seen = Set<String>()
        for news in newsFilterViewModels {
            if !seen.contains(news.name) {
                newsSource.append(news)
                seen.insert(news.name)
            }
        }
    }
    
    // MARK: - SearchBar
   
    func setupMainTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + 210
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        mainTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        mainTableView.separatorColor = .textBlue
        mainTableView.tintColor = .textBlue
        mainTableView.estimatedRowHeight = 200
//        mainTableView.tableFooterView = UIView()
        mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        mainTableView.dataSource = self
        mainTableView.delegate = self
        self.view.addSubview(mainTableView)
        self.mainTableView.addSubview(refreshControl)
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: stackViewAll.bottomAnchor, constant: 10).isActive = true
    }

    func setupCountryTableView() {
        countryPickerView.delegate = self
        countryPickerView.backgroundColor = .backGrey
        countryPickerView.isHidden = true
        countryPickerView.dataSource = self
        self.view.addSubview(countryPickerView)
    }

    func setupCategoryTableView(){
        categoryPickerView.delegate = self
        categoryPickerView.backgroundColor = .backGrey
        categoryPickerView.isHidden = true
        categoryPickerView.dataSource = self
        self.view.addSubview(categoryPickerView)
    }
    
    func setupSourceTableView(){
        sourcePickerView.delegate = self
        sourcePickerView.backgroundColor = .backGrey
        sourcePickerView.isHidden = true
        sourcePickerView.dataSource = self
        self.view.addSubview(sourcePickerView)
    }
    
    func setupStackView() {
        
        stackViewAll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewAll.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        if #available(iOS 11, *) {
          let guide = view.safeAreaLayoutGuide
          NSLayoutConstraint.activate([
            stackViewAll.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
           ])
        } else {
           let standardSpacing: CGFloat = 8.0
           NSLayoutConstraint.activate([
           stackViewAll.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
           ])
        }
        stackViewAll.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10)
        stackViewAll.addArrangedSubview(btnCountry)
        stackViewAll.addArrangedSubview(btnCategory)
        stackViewAll.addArrangedSubview(btnSource)
        stackViewAll.addArrangedSubview(datePickerView)
    }
    
    func setupBtn() {
        btnCountry.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        btnCategory.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        btnSource.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        datePickerView.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        btnCountry.setTitleColor(.textBlue, for: .normal)
        btnCategory.setTitleColor(.textBlue, for: .normal)
        btnSource.setTitleColor(.textBlue, for: .normal)
        datePickerView.tintColor = .textBlue
        datePickerView.inputViewController?.title = "Pick a date"
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        btnCountry.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnCategory.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnSource.heightAnchor.constraint(equalToConstant: 30).isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnCountry.rightImage(image: UIImage(named: "addBtn")!)
        btnCategory.rightImage(image: UIImage(named: "addBtn")!)
        btnSource.rightImage(image: UIImage(named: "addBtn")!)
        favBtn.setImage(UIImage(named: "favorite"), for: .normal)
        favBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        favBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnCountry.addTarget(self, action: #selector(countryBtnAct), for: .touchUpInside)
        btnCategory.addTarget(self, action: #selector(categoryBtnAct), for: .touchUpInside)
        btnSource.addTarget(self, action: #selector(sourceBtnAct), for: .touchUpInside)
        datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        favBtn.addTarget(self, action: #selector(openWishList), for: .touchUpInside)
    }
    
    func setupSpinner() {
        spinner.color = .malina
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60)
        self.mainTableView.tableFooterView = spinner
    }
    
    func getSavedWishes() {
        
        let savedWishes = persistenceManager.fetch(WishList.self)
        self.savedTitles = savedWishes
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
//            print(self.badgeCount.text)
            if self.savedTitles.count == 0 {
                self.badgeCount.isHidden = true
            } else {
                self.badgeCount.isHidden = false
                self.badgeCount.text = "\(savedWishes.count)"
            }
        }
    }
    
    @objc func openWishList() {
        mainCoordinator?.wishClick()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime]
        let string = iso8601DateFormatter.string(from: datePickerView.date)

        fetchDate(publishedAt: string)
    }
    
    @objc func handleRefresh(_ sender: AnyObject) {
       // Code to refresh table view
       mainTableView.reloadData()
       refreshControl.endRefreshing() // End Refreshing
    }
    
   @objc func countryBtnAct() {
        print("Button is tapped")
       if countryPickerView.isHidden == true {
           countryPickerView.isHidden = false
       } else{
           countryPickerView.isHidden = true
       }
    }
    @objc func categoryBtnAct() {
         print("Button is tapped")
        if categoryPickerView.isHidden == true {
            categoryPickerView.isHidden = false
        } else{
            categoryPickerView.isHidden = true
        }
     }
    @objc func sourceBtnAct() {
         print("Button is tapped")
        if sourcePickerView.isHidden == true {
            sourcePickerView.isHidden = false
        } else{
            sourcePickerView.isHidden = true
        }
     }
    
}

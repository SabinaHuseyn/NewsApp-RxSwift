//
//  ViewController.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import UIKit
import AlamofireImage
import CoreData
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
    let searchController = UISearchController(searchResultsController: nil)
    var articlesViewModels = BehaviorRelay<[ObservableViewModel.ArticlesFilterViewModel]>(value: [])
    var newsCountry = BehaviorRelay<[String]>(value: [])
    var newsCategory = BehaviorRelay<[String]>(value: [])
    var newsSource = BehaviorRelay<[String]>(value: [])
    var savedNews = BehaviorRelay<[WishList]>(value: [])
    let disposeBag = DisposeBag()
    var mainTableView: UITableView!
    var countryPickerView = UIPickerView()
    var categoryPickerView = UIPickerView()
    var sourcePickerView = UIPickerView()
    var spinner = UIActivityIndicatorView()
    var container: NSPersistentContainer!
    let persistenceManager = PersistenceManager.shared
    weak var mainCoordinator: MainCoordinator?
    let favBtn = UIButton()
    //    var offset = UIOffset()
    
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
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        UINavigationBar.appearance().tintColor = .textBlue
        view.addSubview(stackViewAll)
        view.backgroundColor = .white
        favBtn.addSubview(badgeCount)
        setupSearch()
        setupFavs()
        setupStackView()
        setupBtn()
        setupMainTableView()
        setupPickerViews()
        filterNews()
        setupCountryPickerViews()
        setupCountryPickerTapHandling()
        setupCategoryPickerViews()
        setupCategoryPickerTapHandling()
        setupSourcePickerViews()
        setupSourcePickerTapHandling()
        setupSearching()
        setupMainCell()
        setupCellTapHandling()
        //        clearCoreDataStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        let rightNavBarButton = UIBarButtonItem(customView:favBtn)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        DispatchQueue.main.async{
            self.setupFavs()
            self.navigationItem.backButtonTitle = ""
        }
    }
    
//    MARK: - Rx Core Data
    
    func setupFavs() {
        getSavedFavToObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                var array = self.savedNews.value
                array.removeAll()
                self.savedNews.accept(data)
                if self.savedNews.value.count == 0 {
                    self.badgeCount.isHidden = true
                } else {
                    self.badgeCount.isHidden = false
                    self.badgeCount.text = "\(self.savedNews.value.count)"
                }
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
    
    //    MARK: - CLEAR CORE DATA
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
    
    // MARK: - UI SETUP    
    func setupMainTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + 210
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        mainTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        mainTableView.separatorColor = .textBlue
        mainTableView.tintColor = .textBlue
        mainTableView.estimatedRowHeight = 200
        mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        self.view.addSubview(mainTableView)
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: stackViewAll.bottomAnchor, constant: 10).isActive = true
        self.mainTableView.keyboardDismissMode = .onDrag
        
    }
    
    func setupPickerViews() {
        countryPickerView.center = view.center
        countryPickerView.setup()
        self.view.addSubview(countryPickerView)
        categoryPickerView.center = view.center
        categoryPickerView.setup()
        categoryPickerView.isHidden = true
        self.view.addSubview(categoryPickerView)
        sourcePickerView.center = view.center
        sourcePickerView.setup()
        sourcePickerView.isHidden = true
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
        stackViewAll.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        stackViewAll.addArrangedSubview(btnCountry)
        stackViewAll.addArrangedSubview(btnCategory)
        stackViewAll.addArrangedSubview(btnSource)
    }
    
    func setupBtn() {
        btnCountry.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        btnCategory.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        btnSource.widthAnchor.constraint(equalTo: stackViewAll.widthAnchor).isActive = true
        favBtn.setImage(UIImage(named: "favorite"), for: .normal)
        favBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        favBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnCountry.addTarget(self, action: #selector(countryBtnAct), for: .touchUpInside)
        btnCategory.addTarget(self, action: #selector(categoryBtnAct), for: .touchUpInside)
        btnSource.addTarget(self, action: #selector(sourceBtnAct), for: .touchUpInside)
        favBtn.addTarget(self, action: #selector(openWishList), for: .touchUpInside)
    }
    
    func setupSearch() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.loadViewIfNeeded()
        definesPresentationContext = true
    }
    
    //    MARK: - @objc ACTIONS
    @objc func openWishList() {
        mainCoordinator?.wishClick()
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
    //   MARK: Rx Setup
    
    func setupSearching() {
        
        searchBar
            .rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[ObservableViewModel.ArticlesFilterViewModel]> in
                if query.isEmpty {
                    return .just([])
                }
                return ObservableViewModel.shared.textSearchChange(query)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                var array = self.articlesViewModels.value
                array.removeAll()
                self.articlesViewModels.accept(data)
            })
            .disposed(by: disposeBag)
    }
}



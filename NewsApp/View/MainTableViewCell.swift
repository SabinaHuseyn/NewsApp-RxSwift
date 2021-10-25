//
//  MainTableViewCell.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.09.21.
//

import UIKit
import AlamofireImage
import CoreData

protocol WishDelegate {
    func getSavedWishes()
}
class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var container: NSPersistentContainer!
    let persistenceManager = PersistenceManager.shared
    var wishSaved: Bool!
    var title: String?
    var wishDelegate: WishDelegate?
    var articlesFilterViewModel: ObservableViewModel.ArticlesFilterViewModel!
    var favNews: WishList?

    override func prepareForReuse() {
        super.prepareForReuse()
        self.articleImg.af.cancelImageRequest()
        self.articleImg.image = nil
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
        self.favNews = favNews
        print("ETO TITLE\(String(describing: self.title))")
    }
            
    @IBAction func clickLike(_ sender: UIButton) {
        
        
    }

        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
}

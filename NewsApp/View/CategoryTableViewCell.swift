//
//  CategoryTableViewCell.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var categoryLbl = UILabel()
    
    var newsFilterViewModel: NewsFilterViewModel! {
        didSet {
            self.categoryLbl.text = newsFilterViewModel.category
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        categoryLbl = UILabel(frame: contentView.bounds)
        contentView.addSubview(categoryLbl)
        categoryLbl.setupLbl()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}

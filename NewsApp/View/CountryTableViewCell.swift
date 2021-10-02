//
//  CountryTableViewCell.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var countryLbl = UILabel()
    
    var newsFilterViewModel: NewsFilterViewModel! {
        didSet {
            self.countryLbl.text = newsFilterViewModel.country
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        countryLbl = UILabel(frame: contentView.bounds)
        contentView.addSubview(countryLbl)
        countryLbl.setupLbl()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        countryLbl.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }


}

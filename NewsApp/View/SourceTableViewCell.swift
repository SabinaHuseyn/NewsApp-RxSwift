//
//  SourceTableViewCell.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    var sourceLbl = UILabel()
    
    var newsFilterViewModel: NewsFilterViewModel! {
        didSet {
            self.sourceLbl.text = newsFilterViewModel.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        sourceLbl = UILabel(frame: contentView.bounds)
        contentView.addSubview(sourceLbl)
        sourceLbl.setupLbl()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sourceLbl.translatesAutoresizingMaskIntoConstraints = false
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}

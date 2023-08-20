//
//  SearchResultTableViewCell.swift
//  xinsta
//
//  Created by t2023-m0075 on 2023/08/17.
//

import UIKit


class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUserName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

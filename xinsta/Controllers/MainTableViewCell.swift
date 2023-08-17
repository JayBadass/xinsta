//
//  MainTableViewCell.swift
//  xinsta
//
//  Created by Jongbum Lee on 2023/08/14.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var commentButton: UIImageView!
    @IBOutlet weak var likeButton: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var likeCounts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

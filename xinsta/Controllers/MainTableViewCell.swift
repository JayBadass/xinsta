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
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var likeCounts: UILabel!
    
    var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @objc func didTapLikeButton() {
        isLiked.toggle() // 좋아요 상태 토글
    }
    
}

//
//  ProfilePageViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var profilePageNavigationItem: UINavigationItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        guard let myProfile = users.first(where: {$0.username == myInfo?.username}) else { return }
        
        profilePageNavigationItem.title = myProfile.username
        
        profileImageView.image = myProfile.profilePhoto
        profileImageView.circleImage = true
        
        postsLabel.text = ("\(myProfile.counts.posts)")
        followersLabel.text = ("\(myProfile.counts.followers)")
        followingLabel.text = ("\(myProfile.counts.following)")
        
        usernameLabel.text = myProfile.username
        
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 0.5
        editProfileButton.layer.borderColor = UIColor.lightGray.cgColor
        
        bioLabel.text = myProfile.bio

        updateLabelLayout(bioLabel)
    }
    
    // FIXME: 더보기/접기 글씨 없음, label 전체 터치됨
    func isTextOverflowing(_ label: UILabel) -> Bool {
        let textLength = label.text?.count ?? 0
        let textHeight = label.text?.boundingRect(with: CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : label.font!], context: nil).height ?? 0
        return textLength > 0 && textHeight > label.frame.height
    }
    
    func updateLabelLayout(_ label: UILabel) {
        if isTextOverflowing(label) {
            label.lineBreakMode = .byTruncatingTail
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(biolabelTapped))
            label.addGestureRecognizer(tapGesture)
        } else {
            label.lineBreakMode = .byWordWrapping
            label.isUserInteractionEnabled = false
            label.gestureRecognizers?.removeAll()
            let heightConstraint = label.heightAnchor.constraint(equalToConstant: 54)
            heightConstraint.isActive = true
        }
    }
    
    @objc func biolabelTapped(sender: UITapGestureRecognizer) {
        if isExpanded {
            bioLabel.numberOfLines = 3
        } else {
            bioLabel.numberOfLines = 0
        }
        isExpanded.toggle()
        view.layoutIfNeeded()
    }

}

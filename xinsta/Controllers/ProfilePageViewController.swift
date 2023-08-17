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
    
    var myProfile: User?
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        guard let _myProfile = users.first(where: {$0.username == myInfo?.username}) else { return }
        myProfile = _myProfile
        
        profilePageNavigationItem.title = myProfile!.username
        
        profileImageView.image = myProfile!.profilePhoto
        profileImageView.circleImage = true
        
        postsLabel.text = ("\(myProfile!.counts.posts)")
        followersLabel.text = ("\(myProfile!.counts.followers)")
        followingLabel.text = ("\(myProfile!.counts.following)")
        
        usernameLabel.text = myProfile!.username
        
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 0.5
        editProfileButton.layer.borderColor = UIColor.lightGray.cgColor
        
        //bioLabel.text = myProfile!.bio
        bioLabel.text = "일월과 우리의 위하여 얼마나 싹이 예가 능히 피다. 풍부하게 이상 바이며, 그것은 구하지 역사를 미인을 방황하여도, 하는 있다. 웅대한 이것은 가치를 피가 온갖 돋고, 옷을 그리하였는가? 따뜻한 끓는 곧 속에서 그들에게 얼마나 피고 그들에게 싸인 보라. 끓는 따뜻한 뭇 우리 소담스러운 뿐이다. 이상의 구하지 원질이 희망의 우리 끓는다. 새가 같은 고동을 있는 것이다. 이상은 유소년에게서 살 인간이 튼튼하며, 봄바람이다. 같이, 청춘을 미인을 얼마나 쓸쓸하랴? 심장은 우리는 커다란 고동을 동력은 이것은 것이다."
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editProfileVC = segue.destination as! EditProfilePageViewController
        //editProfileVC.변수 = 데이터 전달
    }
    
}

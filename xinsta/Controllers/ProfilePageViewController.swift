//
//  ProfilePageViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

class ProfilePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var profilePageNavigationItem: UINavigationItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    var isExpanded = false
    let images = posts.filter {$0.owner == myInfo!}.map {$0.thumbnailImage}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        guard let myProfile = users.first(where: {$0.username == myInfo!}) else { return }
        
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
        
        postsCollectionView.dataSource = self
        postsCollectionView.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        postsCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.collectionViewCell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellItemForRow: CGFloat = 3
        let minimumSpacing: CGFloat = 2
        let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1  // 세로 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1  // 가로 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)  // 여백 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailSegueIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegueIdentifier" {
            // 목적지 뷰 컨트롤러 가져오기
            if let detailPageViewController = segue.destination as? DetailPageViewController {
                // 선택된 셀의 인덱스 가져오기
                if let indexPath = postsCollectionView.indexPathsForSelectedItems?.first {
                    // 필요한 데이터 전달하기
                    detailPageViewController.selectedPostIndex = indexPath.row
                }
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.confirmLogout()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func confirmLogout() {
        let confirmAlertController = UIAlertController(title: "Confirm Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            self.performLogout()
        }
        
        confirmAlertController.addAction(cancelAction)
        confirmAlertController.addAction(confirmAction)
        
        present(confirmAlertController, animated: true, completion: nil)
    }
    
    func performLogout() {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
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

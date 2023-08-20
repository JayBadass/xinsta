//
//  ProfilePageViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

class SearchDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tableViewProfileImageView: UIImageView!
    @IBOutlet weak var tableViewPostsLabel: UILabel!
    @IBOutlet weak var tableViewFollowersLabel: UILabel!
    @IBOutlet weak var tableViewFollowingLabel: UILabel!
    @IBOutlet weak var tableViewNameLabel: UILabel!
    @IBOutlet weak var tableViewBioLabel: UILabel!
    @IBOutlet weak var tableViewPostCollectionView: UICollectionView!
    
    var selectedUserName: String?
    
    var isExpanded = false
    var images: [UIImage] = []
    
    //let images = posts.filter {$0.owner == selectedUserName!}.map {$0.thumbnailImage}
    // $0.owner == myInfo! -> myInfo 부분을 tableViewCell 에 있는 유저의 이름으로 변경
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        setupUI()
    }
    
    func setupUI() {
        
        images = posts.filter {$0.owner == selectedUserName}.map {$0.thumbnailImage!}
        
        guard let myProfile = users.first(where: {$0.username == selectedUserName!}) else { return }
        //$0.username == myInfo! -> myInfo 부분을 tableViewCell 에 있는 유저의 이름으로 변경
        
//        profilePageNavigationItem.title = myProfile.username
//
        tableViewProfileImageView.image = myProfile.profilePhoto
        tableViewProfileImageView.circleImage = true
        
        tableViewPostsLabel.text = ("\(myProfile.counts.posts)")
        tableViewFollowersLabel.text = ("\(myProfile.counts.followers)")
        tableViewFollowingLabel.text = ("\(myProfile.counts.following)")
        
        tableViewNameLabel.text = myProfile.username
        
        tableViewBioLabel.text = myProfile.bio

        updateLabelLayout(tableViewBioLabel)
        
        tableViewPostCollectionView.dataSource = self
        tableViewPostCollectionView.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        tableViewPostCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
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
        
        // 셀이 선택되었을 때 수행할 작업을 여기에 구현
        
        // 세그웨이 실행
        self.performSegue(withIdentifier: "SearchDetailSegueIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchDetailSegueIdentifier" {
            // 목적지 뷰 컨트롤러 가져오기
            if let detailPageViewController = segue.destination as? DetailPageViewController {
                // 선택된 셀의 인덱스 가져오기
                if let indexPath = tableViewPostCollectionView.indexPathsForSelectedItems?.first {
                    // 필요한 데이터 전달하기
                    detailPageViewController.selectedPostIndex = indexPath.row
                }
            }
        }
    }
    
    @objc func biolabelTapped(sender: UITapGestureRecognizer) {
        if isExpanded {
            tableViewBioLabel.numberOfLines = 3
        } else {
            tableViewBioLabel.numberOfLines = 0
        }
        isExpanded.toggle()
        view.layoutIfNeeded()
    }
    
}


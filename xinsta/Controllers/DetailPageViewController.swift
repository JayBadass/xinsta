//
//  DetailPageViewController.swift
//  xinsta
//
//  Created by Jongbum Lee on 2023/08/17.
//

import UIKit

class DetailPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounts: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var userName: UILabel!
    
    @IBAction func addCommentButtonTapped(_ sender: UIButton) {
        guard let commentText = commentTextField.text, !commentText.isEmpty else {
            return
        }
        
        let currentUser = "currentUser" // 추후 실 사용자로 변경 필요
        
        let newComment = PostComment(username: currentUser, text: commentText)
        posts[selectedPostIndex].comments.append(newComment)
        
        commentTextField.text = ""
        tableView.reloadData()
    }
    
    weak var delegate: DetailPageViewControllerDelegate?
    var selectedPostIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backTapped))
        
        let isLikedByCurrentUser = true
        updateLikeStatus(isLiked: isLikedByCurrentUser)
        
        viewBinding()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func viewBinding() {
        let post = posts[selectedPostIndex]
        
        
        let currentUser = "currentUser" //  추후 실 사용자로 변경 필요
        if post.likeCount.contains(where: { $0.username == currentUser }) {
            // 이미 좋아요한 상태
            likeButton.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else {
            // 좋아요하지 않은 상태
            likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        userName.text = post.owner.username
        postImage.image = post.thumbnailImage
        let postLikes = post.likeCount
        if let firstLiker = postLikes.first {
            likeCounts.text = "\(firstLiker.username)님 외 \(postLikes.count - 1)명이 좋아합니다"
        } else {
            likeCounts.text = ""
        }
        likeButton.addTarget(self, action: #selector(didTapLike(_:)), for: .touchUpInside)
        likeButton.tag = selectedPostIndex  // 현재 indexPath.row를 태그로 사용하여 어떤 게시물의 좋아요 버튼이 눌렸는지 판별
        postUserName.text = post.owner.username
        caption.text = post.caption
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: post.createdDate)
        postDate.text = dateString
        
        let isLikedByCurrentUser = post.likeCount.contains { $0.username == "currentUser" } // "currentUser"는 현재 사용자의 이름을 나타냅니다.
        updateLikeStatus(isLiked: isLikedByCurrentUser)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts[selectedPostIndex].comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPageTableViewCell", for: indexPath) as! DetailPageTableViewCell
        
        let comment = posts[selectedPostIndex].comments[indexPath.row]
        cell.userName?.text = comment.username
        cell.comment.text = comment.text
        return cell
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateLikeStatus(isLiked: Bool) {
        let imageName = isLiked ? "heart_filled" : "heart"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc func didTapLike(_ sender: UIButton) {
        
        let currentUser = "currentUser" // 추후 실 사용자로 변경 필요
        
        if posts[selectedPostIndex].likeCount.contains(where: { $0.username == currentUser }) {
            // 이미 좋아요한 상태이면 좋아요 취소
            if let index = posts[selectedPostIndex].likeCount.firstIndex(where: { $0.username == currentUser }) {
                posts[selectedPostIndex].likeCount.remove(at: index)
            }
        } else {
            // 좋아요하지 않은 상태이면 좋아요 추가
            let newLike = PostLike(username: currentUser, postIdentifier: "")
            posts[selectedPostIndex].likeCount.append(newLike)
        }
        
        // 좋아요 버튼 상태와 라벨 업데이트
        updateLikeStatus(isLiked: posts[selectedPostIndex].likeCount.contains { $0.username == currentUser })
        let postLikes = posts[selectedPostIndex].likeCount
        if let firstLiker = postLikes.first {
            likeCounts.text = "\(firstLiker.username)님 외 \(postLikes.count - 1)명이 좋아합니다"
        } else {
            likeCounts.text = ""
        }
        
        delegate?.didUpdatePost(at: selectedPostIndex, post: posts[selectedPostIndex])
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

class DetailPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

protocol DetailPageViewControllerDelegate: AnyObject {
    func didUpdatePost(at index: Int, post: UserPost)
}


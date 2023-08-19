//
//  ViewController.swift
//  xinsta
//
//  Created by Jongbum Lee on 2023/08/14.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        let post = posts[indexPath.row]
        let currentUser = myInfo!
        if post.likeCount.contains(where: { $0.username == currentUser }) {
            // 이미 좋아요한 상태
            cell.likeButton.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else {
            // 좋아요하지 않은 상태
            cell.likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        cell.userName.text = posts[indexPath.row].owner
        cell.postImage.image = posts[indexPath.row].thumbnailImage
        let postLikes = posts[indexPath.row].likeCount
        if let firstLiker = postLikes.first {
            cell.likeCounts.text = "\(firstLiker.username)님 외 \(postLikes.count - 1)명이 좋아합니다"
        } else {
            cell.likeCounts.text = ""
        }
        cell.likeButton.addTarget(self, action: #selector(didTapLike(_:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row  // 현재 indexPath.row를 태그로 사용하여 어떤 게시물의 좋아요 버튼이 눌렸는지 판별
        cell.postUserName.text = posts[indexPath.row].owner
        cell.postText.text = posts[indexPath.row].caption
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: posts[indexPath.row].createdDate)
        cell.postDate.text = dateString
        
        return cell
    }
    
    @objc func didTapLike(_ sender: UIButton) {
        let postIndex = sender.tag
        var post = posts[postIndex]
        
        let currentUser = myInfo!
        if let index = post.likeCount.firstIndex(where: { $0.username == currentUser }) {
            // 이미 좋아요한 상태이므로, 좋아요 취소
            post.likeCount.remove(at: index)
            sender.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else {
            // 좋아요 추가
            let like = PostLike(username: currentUser, postId: post.id)
            post.likeCount.append(like)
            sender.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        posts[postIndex] = post
        tableView.reloadRows(at: [IndexPath(row: postIndex, section: 0)], with: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let detailVC = segue.destination as? DetailPageViewController, let selectedIndex = tableView.indexPathForSelectedRow?.row {
            detailVC.selectedPostIndex = selectedIndex
            detailVC.delegate = self
        }
    }
}

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


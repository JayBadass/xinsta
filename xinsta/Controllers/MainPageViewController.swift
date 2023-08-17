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
        let currentUser = "currentUser" //  추후 실 사용자로 변경 필요
        if post.likeCount.contains(where: { $0.username == currentUser }) {
            // 이미 좋아요한 상태
            cell.likeButton.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else {
            // 좋아요하지 않은 상태
            cell.likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        cell.userName.text = posts[indexPath.row].owner.username
        cell.postImage.image = posts[indexPath.row].thumbnailImage
        let postLikes = posts[indexPath.row].likeCount
        if let firstLiker = postLikes.first {
            cell.likeCounts.text = "\(firstLiker.username)님 외 \(postLikes.count - 1)명이 좋아합니다"
        } else {
            cell.likeCounts.text = ""
        }
        cell.likeButton.addTarget(self, action: #selector(didTapLike(_:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row  // 현재 indexPath.row를 태그로 사용하여 어떤 게시물의 좋아요 버튼이 눌렸는지 판별
        cell.postUserName.text = posts[indexPath.row].owner.username
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
        
        let currentUser = "currentUser"
        if let index = post.likeCount.firstIndex(where: { $0.username == currentUser }) {
            // 이미 좋아요한 상태이므로, 좋아요 취소
            post.likeCount.remove(at: index)
            sender.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else {
            // 좋아요 추가
            let like = PostLike(username: currentUser, postIdentifier: "post\(postIndex + 1)")
            post.likeCount.append(like)
            sender.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        posts[postIndex] = post
        tableView.reloadRows(at: [IndexPath(row: postIndex, section: 0)], with: .none)
    }
}


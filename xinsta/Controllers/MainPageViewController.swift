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
        
        cell.userName.text = posts[indexPath.row].owner.username
        cell.postImage.image = posts[indexPath.row].thumbnailImage
        let postLikes = posts[indexPath.row].likeCount
        if let firstLiker = postLikes.first {
            cell.likeCounts.text = "\(firstLiker.username)님 외 \(postLikes.count - 1)명이 좋아합니다"
        } else {
            cell.likeCounts.text = ""
        }
        cell.postUserName.text = posts[indexPath.row].owner.username
        cell.postText.text = posts[indexPath.row].caption
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: posts[indexPath.row].createdDate)
        cell.postDate.text = dateString
        
        return cell
    }
    
    
}


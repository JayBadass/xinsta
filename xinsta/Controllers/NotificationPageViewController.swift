//
//  NotificationPageViewController.swift
//  xinsta
//
//  Created by APPLE M1 Max on 2023/08/17.
//

import UIKit

class NotificationPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications: [Notification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let user = myInfo {
            fetchNotifications(for: user)
        }
        // Do any additional setup after loading the view.
    }
    
    func fetchNotifications(for user: User) {
        // 게시물에 대한 모든 좋아요와 댓글을 찾아 알림으로 변환
        for post in posts.filter({ $0.owner.username == user.username }) {
            for like in post.likeCount {
                notifications.append(Notification(type: .like(username: like.username), post: post, date: Date()))
            }
            for comment in post.comments {
                notifications.append(Notification(type: .comment(username: comment.username, text: comment.text), post: post, date: Date()))
            }
        }
        // 알림을 최신 순으로 정렬
        notifications.sort(by: { $0.date > $1.date })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        let notification = notifications[indexPath.row]
        
        switch notification.type {
        case .like(let username):
            cell.notificationText.text = "\(username)님이 회원님의\n게시글을 좋아합니다."
        case .comment(let username, let text):
            cell.notificationText.text = "\(username)님이 댓글을 남겼습니다. :\n\(text)"
        }
        
        cell.postImage.image = notification.post.thumbnailImage
        // TODO: profileImage 설정
        
        return cell
    }
    
}

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        notificationText.numberOfLines = 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

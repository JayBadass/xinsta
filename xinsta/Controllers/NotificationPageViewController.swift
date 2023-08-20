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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = users.first(where: {$0.username == myInfo}) {
            fetchNotifications(for: user)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchNotifications(for user: User) {
        notifications = []
        for post in posts.filter({ $0.owner == user.username }) {
            for like in post.likeCount {
                notifications.append(Notification(type: .like(username: like.username), post: post, date: like.likedDate))
            }
            for comment in post.comments {
                notifications.append(Notification(type: .comment(username: comment.username, text: comment.text), post: post, date: comment.commentedDate))
            }
        }
        notifications.sort(by: { $0.date > $1.date })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        let notification = notifications[indexPath.row]
        let attributedText: NSAttributedString
        let user: String?
        
        switch notification.type {
        case .like(let username):
            user = username
            attributedText = attributedString(with: username, actionText: "님이 \n회원님의 게시글을 좋아합니다.")
        case .comment(let username, let text):
            user = username
            attributedText = attributedString(with: username, actionText: "님이 댓글을 남겼습니다. :\n\(text)")
        }
        
        cell.notificationText.attributedText = attributedText
        cell.postImage.image = notification.post.thumbnailImage
        cell.profileImage.image = users.first(where: {$0.username == user})!.profilePhoto
        cell.profileImage.circleImage = true
        
        return cell
    }
    
    func attributedString(with username: String, actionText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(username)", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ])
        
        attributedString.append(NSAttributedString(string: actionText, attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]))
        
        return attributedString
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

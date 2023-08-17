//
//  Models.swift
//  xinsta
//
//  Created by Jongbum Lee on 2023/08/14.
//

import Foundation
import UIKit

struct User {
    var username: String
    var bio: String = ""
    var name: (first: String, last: String) = ("","")
    var profilePhoto: UIImage
    var counts: UserCount = UserCount(followers: 0, following: 0, posts: 0)
    var joinDate: Date = Date()
    var password: String
}

struct UserCount {
    var followers: Int
    var following: Int
    var posts: Int
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    //    let thumbnailImage: URL
    let thumbnailImage: UIImage?
    let postURL: URL // either video URL or full resolution photo
    let caption: String?
    var likeCount: [PostLike]
    var comments: [PostComment]
    let createdDate: Date
    let owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct PostComment {
    let username: String
    let text: String
}

var users: [User] = []
var posts: [UserPost] = []
var myInfo: User?

func createDummyData() {
    // User Dummy Data
    for i in 1...5 {
        let user = User(username: "user\(i)",
                        bio: "User \(i) bio",
                        name: (first: "First\(i)", last: "Last\(i)"),
                        profilePhoto: UIImage(systemName: "person.circle.fill")!,
                        counts: UserCount(followers: i*100, following: i*50, posts: i*10),
                        joinDate: Date(), password: "user\(i)")
        users.append(user)
    }
    
    // User Post Dummy Data
    for i in 1...100 {
        let postUser = users[i % 5]
        let post = UserPost(identifier: "post\(i)",
                            postType: i % 2 == 0 ? .photo : .video,
                            //thumbnailImage: URL(string: "https://example.com/post\(i)_thumb.jpg")!,
                            thumbnailImage: UIImage(named: "panda"),
                            postURL: i % 2 == 0 ? URL(string: "https://example.com/post\(i).jpg")! : URL(string: "https://example.com/post\(i)_video.mp4")!,
                            caption: "Caption for post \(i)",
                            likeCount: (1...5).map { PostLike(username: "user\($0)", postIdentifier: "post\(postUser.username)_\(i)") },
                            comments: (1...5).map { PostComment(
                                username: "user\($0)",
                                text: "Comment \($0) for post \(postUser.username)_\(i)"
                            )},
                            
                            createdDate: Date(),
                            owner: postUser)
        posts.append(post)
    }
}


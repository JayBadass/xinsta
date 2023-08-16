//
//  Models.swift
//  xinsta
//
//  Created by Jongbum Lee on 2023/08/14.
//

import Foundation
import UIKit

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
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
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
    let password: String
}

var users: [User] = []
var posts: [UserPost] = []

func createDummyData() {
    // User Dummy Data
    for i in 1...5 {
        let user = User(username: "user\(i)",
                        bio: "User \(i) bio",
                        name: (first: "First\(i)", last: "Last\(i)"),
                        profilePhoto: URL(string: "https://example.com/user\(i).jpg")!,
                        counts: UserCount(followers: i*100, following: i*50, posts: i*10),
                        joinDate: Date())
        users.append(user)
    }

    // User Post Dummy Data
    for i in 1...100 {
        let postUser = users[i % 5]
        let post = UserPost(identifier: "post\(i)",
                            postType: i % 2 == 0 ? .photo : .video,
//                            thumbnailImage: URL(string: "https://example.com/post\(i)_thumb.jpg")!,
                            thumbnailImage: UIImage(named: "panda"),
                            postURL: i % 2 == 0 ? URL(string: "https://example.com/post\(i).jpg")! : URL(string: "https://example.com/post\(i)_video.mp4")!,
                            caption: "Caption for post \(i)",
                            likeCount: [PostLike(username: postUser.username, postIdentifier: "post\(i)")],
                            comments: [PostComment(identifier: "comment\(i)",
                                                   username: postUser.username,
                                                   text: "Comment for post \(i)",
                                                   createdDate: Date(),
                                                   likes: [CommentLike(username: postUser.username, commentIdentifier: "comment\(i)")])],
                            createdDate: Date(),
                            owner: postUser)
        posts.append(post)
    }
}


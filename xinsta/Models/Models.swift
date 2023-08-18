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

public struct UserPost {
    let id = UUID()
    let thumbnailImage: UIImage?
    let caption: String
    var likeCount: [PostLike] = []
    var comments: [PostComment] = []
    let createdDate: Date = Date()
    let owner: User
}

struct PostLike {
    let username: String
    let postId: UUID
}

struct PostComment {
    let username: String
    let text: String
}

enum NotificationType {
    case like(username: String)
    case comment(username: String, text: String)
}

struct Notification {
    let type: NotificationType
    let post: UserPost
    let date: Date
}


var users: [User] = []
// FIXME: createdDate로 정렬
var posts: [UserPost] = []
var myInfo: User?

func createDummyData() {

}


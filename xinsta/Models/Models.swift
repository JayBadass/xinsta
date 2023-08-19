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
    var createdDate: Date = Date()
    let owner: String
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

let createdDate: Date = Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!

var users: [User] = [User(username: "hojxll_34", bio: "Et per etiam eirmod persecuti, impetus eruditi incorrupte sea te. Option mandamus no duo. Mea id animal dissentiet, nulla affert cu eos, vel zril inciderint id. Ex pri appetere atomorum, ex vis audiam saperet. Nam eu repudiare adipiscing dissentiunt, tale saepe laboramus usu ne. Molestiae comprehensam sed et, mei cu homero salutatus.", profilePhoto: UIImage(named: "gwwdr")!, counts: UserCount(followers: 46, following: 20, posts: 0), password: "aaaaa1"),
                     User(username: "5soold.", bio: "Et per \netiam eirmod \npersecuti", profilePhoto: UIImage(named: "66cc0fed32")!, counts: UserCount(followers: 984, following: 89, posts: 0), password: "aaaaa1"),
                     User(username: "x_dfj.zz", profilePhoto: UIImage(named: "ncde")!, counts: UserCount(followers: 167, following: 182, posts: 0), password: "aaaaa1"),
                     User(username: "e.xegg34", bio: "Et per", name: (first: "Jaehee", last: "Lee"), profilePhoto: UIImage(named: "output_2572710016")!, counts: UserCount(followers: 46, following: 20, posts: 0), password: "aaaaa1")
//                     ,
//                     User(username: "mongmong", bio: "안녕하세요! 저는 몽이라고 해요!", name: (first: "", last: ""), profilePhoto: UIImage(named: "mong3")!, counts: UserCount(followers: 8831, following: 183, posts: 0), password: "mong123"),
//                     User(username: "nal_doo", bio: "siuuuuuu!", name: (first: "nal", last: "doo"), profilePhoto: UIImage(named: "siu")!, counts: UserCount(followers: 1855, following: 253, posts: 0), password: "naldoo123"),
//                     User(username: "goat_messi", bio: "GOAT", name: (first: "", last: ""), profilePhoto: UIImage(named: "messigoat")! , counts: UserCount(followers: 9999, following: 112, posts: 0), password: "goat123")
]

// FIXME: createdDate로 정렬
var posts: [UserPost] = [UserPost(thumbnailImage: UIImage(named: "5nvzjlzgjfum_m"), caption: "Et per etiam eirmod persecuti, impetus eruditi incorrupte sea te. Option mandamus no duo. Mea id animal dissentiet, nulla affert cu eos, vel zril inciderint id. Ex pri appetere atomorum, ex vis audiam saperet. Nam eu repudiare adipiscing dissentiunt, tale saepe laboramus usu ne. Molestiae comprehensam sed et, mei cu homero salutatus.", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "66cc0fed32"), caption: "hi", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "377979_2"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "20180801144452_65527fe4cc062604bf791eed589909d0_y8mb"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "body_1646363596"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "image_2661538551521867165449"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_3121_jpg"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_3144_jpg"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_4396_jpg"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_4401"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_6447"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_6683"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "KakaoTalk_20210813_225508726_10"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "KakaoTalk_20210813_225508726_12"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "KakaoTalk_20210813_225508726"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "lse15070709"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "ocean-4243709_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "paris-2763066_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "tavern-7411977_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "woman-5779323_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2000, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         
].sorted(by: {$0.createdDate > $1.createdDate})
var myInfo: String?

func createDummyData() {

}


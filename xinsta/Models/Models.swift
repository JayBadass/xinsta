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
    var owner: String
}

struct PostLike {
    let username: String
    let postId: UUID
    var likedDate = Date()
}

struct PostComment {
    let username: String
    let text: String
    var commentedDate = Date()
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

var users: [User] = [User(username: "hojxll_34", bio: "Et per etiam eirmod persecuti, impetus eruditi incorrupte sea te. Option mandamus no duo. Mea id animal dissentiet, nulla affert cu eos, vel zril inciderint id. Ex pri appetere atomorum, ex vis audiam saperet. Nam eu repudiare adipiscing dissentiunt, tale saepe laboramus usu ne. Molestiae comprehensam sed et, mei cu homero salutatus.", profilePhoto: UIImage(named: "gwwdr")!, counts: UserCount(followers: 1346, following: 20, posts: 18), password: "aaaaa1"),
                     User(username: "5xsoold.", bio: "안녕하세요.", profilePhoto: UIImage(named: "66cc0fed32")!, counts: UserCount(followers: 984, following: 89, posts: 2), password: "aaaaa1"),
                     User(username: "x_dfj.zz", bio: "패션 저장소", profilePhoto: UIImage(named: "fashion")!, counts: UserCount(followers: 167, following: 182, posts: 4), password: "aaaaa1"),
                     User(username: "e.xegg34", bio: "이강인 팬 페이지", profilePhoto: UIImage(named: "gangin")!, counts: UserCount(followers: 43346, following: 20, posts: 5), password: "aaaaa1"),
                     User(username: "mongmong", bio: "안녕하세요! 저는 몽이라고 해요!", profilePhoto: UIImage(named: "mong")!, counts: UserCount(followers: 28831, following: 183, posts: 16), password: "aaaaa1"),
                     User(username: "xjongwon", bio: "그게 자랑이에유?", profilePhoto: UIImage(named: "food")!, counts: UserCount(followers: 11855, following: 253, posts: 9), password: "aaaaa1"),
                     User(username: "xcalibur", bio: "", profilePhoto: UIImage(named: "trip")! , counts: UserCount(followers: 9999, following: 112, posts: 8), password: "aaaaa1")
]

// FIXME: createdDate로 정렬
var posts: [UserPost] = [UserPost(thumbnailImage: UIImage(named: "5nvzjlzgjfum_m"), caption: "Et per etiam eirmod persecuti, impetus eruditi incorrupte sea te. Option mandamus no duo. Mea id animal dissentiet, nulla affert cu eos, vel zril inciderint id. Ex pri appetere atomorum, ex vis audiam saperet. Nam eu repudiare adipiscing dissentiunt, tale saepe laboramus usu ne. Molestiae comprehensam sed et, mei cu homero salutatus.", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 21, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "66cc0fed32"), caption: "hi", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "377979_2"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 13, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "20180801144452_65527fe4cc062604bf791eed589909d0_y8mb"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 25, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "body_1646363596"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 5, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "image_2661538551521867165449"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 29, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_3121_jpg"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 7, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_3144_jpg"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 28, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_4396_jpg"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 29, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_4401"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 5, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_6447"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 6, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "IMG_6683"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 29, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "KakaoTalk_20210813_225508726_10"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 10, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "KakaoTalk_20210813_225508726_12"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 19, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "KakaoTalk_20210813_225508726"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 2, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "lse15070709"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 10, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "ocean-4243709_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 13, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "paris-2763066_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 20, hour: 20, minute: 15))!, owner: "hojxll_34"),
                         UserPost(thumbnailImage: UIImage(named: "tavern-7411977_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 16, hour: 20, minute: 15))!, owner: "5xsoold."),
                         UserPost(thumbnailImage: UIImage(named: "woman-5779323_640"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 11, hour: 20, minute: 15))!, owner: "5xsoold."),
                         UserPost(thumbnailImage: UIImage(named: "mong1"), caption: "빤 - 히", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 2, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong2"), caption: "몽 \n몽", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 28, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong3"), caption: "몽 \n몽 \n몽", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 17, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong4"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 29, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong5"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 4, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong6"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 16, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong7"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 20, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong8"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong9"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong10"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 27, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong11"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 17, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong12"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 28, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong13"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 1, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong14"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 3, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong15"), caption: "", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 13, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "mong16"), caption: "잔든몽", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 19, hour: 20, minute: 15))!, owner: "mongmong"),
                         UserPost(thumbnailImage: UIImage(named: "food1"), caption: "힘들 때 먹을것은 육류다.", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 18, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food2"), caption: "🍕", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 3, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food3"), caption: "🌯🍺", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 30, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food4"), caption: "닭날개 고추장 쪼림.......에 바지를 겨뜨린.....", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 27, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food5"), caption: "돈까쓰윙스", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 11, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food6"), caption: "FIVE GUYS🍔", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 6, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food7"), caption: "아웃닭", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 29, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food8"), caption: "프랜치랙", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 5, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "food9"), caption: "가평 돌짜장", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15, hour: 20, minute: 15))!, owner: "xjongwon"),
                         UserPost(thumbnailImage: UIImage(named: "trip1"), caption: "✈️", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 26, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip2"), caption: "🇮🇹", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 29, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip3"), caption: "콜로세움🇮🇹", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 4, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip4"), caption: "카프리 섬🇮🇹", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 28, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip5"), caption: "🇮🇹", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip6"), caption: "인터라켄 역🇨🇭", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 4, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip7"), caption: "융프라우🇨🇭", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 18, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "trip8"), caption: "에펠탑🇫🇷", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 21, hour: 20, minute: 15))!, owner: "xcalibur"),
                        UserPost(thumbnailImage: UIImage(named: "fashion1"), caption: "1", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 16, hour: 20, minute: 15))!, owner: "x_dfj.zz"),
                        UserPost(thumbnailImage: UIImage(named: "fashion2"), caption: "2", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 27, hour: 20, minute: 15))!, owner: "x_dfj.zz"),
                        UserPost(thumbnailImage: UIImage(named: "fashion3"), caption: "3", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 6, hour: 20, minute: 15))!, owner: "x_dfj.zz"),
                        UserPost(thumbnailImage: UIImage(named: "fashion4"), caption: "4", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 5, day: 14, hour: 20, minute: 15))!, owner: "x_dfj.zz"),
                        UserPost(thumbnailImage: UIImage(named: "gangin1"), caption: "1", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 15, hour: 20, minute: 15))!, owner: "e.xegg34"),
                        UserPost(thumbnailImage: UIImage(named: "gangin2"), caption: "2", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 12, hour: 20, minute: 15))!, owner: "e.xegg34"),
                        UserPost(thumbnailImage: UIImage(named: "gangin3"), caption: "3", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 10, hour: 20, minute: 15))!, owner: "e.xegg34"),
                        UserPost(thumbnailImage: UIImage(named: "gangin4"), caption: "4", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 29, hour: 20, minute: 15))!, owner: "e.xegg34"),
                        UserPost(thumbnailImage: UIImage(named: "gangin5"), caption: "5", createdDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 31, hour: 20, minute: 15))!, owner: "e.xegg34")
                         
].sorted(by: {$0.createdDate > $1.createdDate})

var myInfo: String?

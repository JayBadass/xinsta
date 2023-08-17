//
//  Extensions.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

extension UIImageView {
    
    var circleImage: Bool {
        set {
            if newValue {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.borderWidth = 0.5
                self.layer.cornerRadius = 0.5 * self.bounds.size.width
                self.clipsToBounds = true
            } else {
                self.layer.cornerRadius = 0
                self.clipsToBounds = true
            }
        } get {
            return false
        }
    }
}

extension MainViewController: DetailPageViewControllerDelegate {
    func didUpdatePost(at index: Int, post: UserPost) {
        posts[index] = post
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}

extension UIButton {
    
    var circleImage: Bool {
        set {
            if newValue {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.borderWidth = 0.5
                self.layer.cornerRadius = 0.5 * self.bounds.size.width
                self.clipsToBounds = true
            } else {
                self.layer.cornerRadius = 0
                self.clipsToBounds = true
            }
        } get {
            return false
        }
    }
    
}

extension String {
    var isValidCredential: Bool {
            let regex = "^(?=.*[a-zA-Z])(?=.*\\d).{5,}$"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
        }
}


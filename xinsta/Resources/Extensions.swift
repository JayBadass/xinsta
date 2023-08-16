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

extension String {
    func truncate(to length: Int) -> String {
        if self.count > length {
            return String(self.prefix(length))
        } else {
            return self
        }
    }
    func truncateIfNeeded(to lineCount: Int, truncatedSuffix: String = " ...더보기") -> String {
        let lines = self.components(separatedBy: "\n")
        if lines.count > lineCount {
            let truncatedLines = Array(lines.prefix(lineCount))
            return truncatedLines.joined(separator: "\n") + truncatedSuffix
        } else {
            return self
        }
    }
}




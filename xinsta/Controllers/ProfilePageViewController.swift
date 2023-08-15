//
//  ProfilePageViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profilePageNavigationItem: UINavigationItem!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var originalText: String = ""
    var truncatedText: String = ""
    var labelExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        profileImageView.circleImage = true
        
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 0.5
        editProfileButton.layer.borderColor = UIColor.lightGray.cgColor
        
//        bioLabel.numberOfLines = 3
//        bioLabel.lineBreakMode = .byTruncatingTail
        
//        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.text = "Lorem ipsum dolor\n sit\n amet,\n consectetur adipiscing elit. Sed quis leo quis lorem tincidunt ultrices. Curabitur euismod nisl id eros consequat, vitae malesuada sapien tempor. Fusce quis nisi sit amet augue malesuada aliquet. Donec vitae leo id massa tincidunt faucibus. Sed euismod quam a lacus sagittis, in ullamcorper nisl luctus. Mauris vitae tortor ut nisi fringilla ultricies."
        bioLabel.textColor = .black
        
        updateLabelLayout(bioLabel)
        //setupReadMoreLabel()
    }
    
    func isTextOverflowing(_ label: UILabel) -> Bool {
        // 텍스트의 길이를 계산
        let textLength = label.text?.count ?? 0
        // 텍스트의 높이를 계산
        let textHeight = label.text?.boundingRect(with: CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : label.font!], context: nil).height ?? 0
        // 텍스트가 3줄을 넘는지 판단
        return textLength > 0 && textHeight > label.frame.height
    }

    // 텍스트가 넘치는지 확인하고 적절한 설정을 적용하는 메서드
    func updateLabelLayout(_ label: UILabel) {
        // 텍스트가 넘치면
        if isTextOverflowing(label) {
            // lineBreakMode를 .byTruncatingTail로 설정
            label.lineBreakMode = .byTruncatingTail
            // 탭 제스처 인식기 추가
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(biolabelTapped))
            label.addGestureRecognizer(tapGesture)
        } else {
            // lineBreakMode를 .byWordWrapping으로 설정
            label.lineBreakMode = .byWordWrapping
            // 탭 제스처 인식기 제거
            label.isUserInteractionEnabled = false
            label.gestureRecognizers?.removeAll()
            let heightConstraint = label.heightAnchor.constraint(equalToConstant: 54)
            heightConstraint.isActive = true
        }
    }

    // 탭 이벤트 처리 메서드
    @objc func biolabelTapped() {
        // numberOfLines를 0으로 변경하여 텍스트를 모두 표시함
        bioLabel.numberOfLines = 0
        // 레이아웃 업데이트
        view.layoutIfNeeded()
    }

    
//    func setupReadMoreLabel() {
//        originalText = "Your long text goes hereYour long text goes\n hereYour\n long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes here"
//        truncatedText = originalText.truncateIfNeeded(to: 3)
//
//        let attributedString = NSMutableAttributedString(string: truncatedText)
//        if originalText != truncatedText, let linkRange = (truncatedText as NSString).range(of: " ...더보기") as NSRange? {
//            attributedString.addAttribute(.link, value: "readMore", range: linkRange)
//            bioLabel.isUserInteractionEnabled = true
//        }
//        bioLabel.attributedText = attributedString
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(readMoreTapped(_:)))
//        bioLabel.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func readMoreTapped(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: bioLabel)
//        let textContainer = NSTextContainer(size: bioLabel.bounds.size)
//        let layoutManager = NSLayoutManager()
//        layoutManager.addTextContainer(textContainer)
//
//        let textStorage = NSTextStorage(attributedString: bioLabel.attributedText ?? NSAttributedString())
//        textStorage.addLayoutManager(layoutManager)
//
//        let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//
//        if let linkRange = (truncatedText as NSString).range(of: " ...더보기") as NSRange? {
//            if characterIndex >= linkRange.location && characterIndex < linkRange.location + linkRange.length {
//                labelExpanded.toggle()
//
//                if labelExpanded {
//                    bioLabel.numberOfLines = 0
//                    bioLabel.text = originalText
//                } else {
//                    bioLabel.numberOfLines = 3
//                    bioLabel.text = truncatedText
//                }
//            }
//        }
//    }
    
    
    
    
    //    func setupReadMoreLabel() {
    //        originalText = "Your long text goes hereYour long text goes\n hereYour\n long\n text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes here"
    //        truncatedText = originalText.truncateIfNeeded(to: 3)
    //
    //        let attributedString = NSMutableAttributedString(string: truncatedText)
    //        let range = NSRange(location: truncatedText.count - 4, length: 4) // " ...더보기" 부분에 대한 범위 설정
    //        attributedString.addAttribute(.link, value: "readMore", range: range)
    //        bioLabel.attributedText = attributedString
    //        bioLabel.isUserInteractionEnabled = true
    //
    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(readMoreTapped(_:)))
    //        bioLabel.addGestureRecognizer(tapGesture)
    //    }
    //
    //    @objc func readMoreTapped(_ sender: UITapGestureRecognizer) {
    //        let location = sender.location(in: bioLabel)
    //        let textContainer = NSTextContainer(size: bioLabel.bounds.size)
    //        let layoutManager = NSLayoutManager()
    //        layoutManager.addTextContainer(textContainer)
    //
    //        let textStorage = NSTextStorage(attributedString: bioLabel.attributedText ?? NSAttributedString())
    //        textStorage.addLayoutManager(layoutManager)
    //
    //        let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    //
    //        if let linkRange = bioLabel.attributedText?.string.range(of: " ...더보기") {
    //            if characterIndex >= linkRange.lowerBound.utf16Offset(in: truncatedText) && characterIndex < linkRange.upperBound.utf16Offset(in: truncatedText) {
    //                labelExpanded.toggle()
    //
    //                if labelExpanded {
    //                    bioLabel.numberOfLines = 0
    //                    bioLabel.text = originalText
    //                } else {
    //                    bioLabel.numberOfLines = 1
    //                    bioLabel.text = truncatedText
    //                }
    //            }
    //        }
    //    }
    
    
    
    //    func setupReadMoreLabel() {
    //        originalText = "Your long text goes\n hereYour long\n text goes\n hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes hereYour long text goes here"
    //        truncatedText = originalText.truncateIfNeeded(to: 3)
    //
    //        let attributedString = NSMutableAttributedString(string: truncatedText + " ...더보기")
    //        let range = NSRange(location: truncatedText.count, length: 6)
    //        attributedString.addAttribute(.link, value: "readMore", range: range)
    //        bioLabel.attributedText = attributedString
    //        bioLabel.isUserInteractionEnabled = true
    //
    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(readMoreTapped))
    //        bioLabel.addGestureRecognizer(tapGesture)
    //    }
    //
    //    @objc func readMoreTapped(_ sender: UITapGestureRecognizer) {
    //        labelExpanded.toggle()
    //
    //        if labelExpanded {
    //            bioLabel.numberOfLines = 0
    //            bioLabel.text = originalText
    //        } else {
    //            bioLabel.numberOfLines = 3
    //            bioLabel.text = truncatedText + " ...더보기"
    //        }
    //    }
    
}

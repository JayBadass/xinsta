//
//  SearchDetailViewController.swift
//  xinsta
//
//  Created by t2023-m0075 on 2023/08/18.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var detatilProfileImage: UIImageView!
    @IBOutlet weak var detailView: UIImageView!
    @IBOutlet weak var detailUserName: UILabel!
    @IBOutlet weak var detailCaption: UILabel!
    @IBOutlet weak var detailPostUserName: UILabel!
    @IBOutlet weak var detailPostDate: UILabel!
    @IBOutlet weak var detailLIkeButton: UIButton!
    @IBOutlet weak var detailLikeCounts: UILabel!
    @IBOutlet weak var detailCommentButton: UIButton!
    @IBOutlet weak var detailCommentTextField: UITextField!
    @IBAction func etailAddCommnetButtonTapped(_ sender: UIButton) {
//        guard let commentText = detailCommentTextField.text, !commentText.isEmpty else {
//            return
        }
        
        
        
       // var image: UIImage? // 새로운 UIImage 타입의 프로퍼티 추가
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            // 이미지 데이터를 UIImageView에 설정
            //etailView.image = image
        }
    }

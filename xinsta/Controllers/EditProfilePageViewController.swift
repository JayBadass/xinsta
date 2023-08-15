//
//  EditProfilePageViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

class EditProfilePageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    var selectedImage: UIImage? // 선택한 사진을 임시로 저장 -> 실제 유저 데이터 가져오면 필요없음
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
//        if let newImage = selectedImage {
//            profileImageView.image = newImage
//        }
        profileImageView.circleImage = true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // 프로필 이미지 뷰의 이미지를 업데이트
//        if let newImage = profileImageView.image {
//            // 새로운 이미지를 설정
//            profileImageView.image = newImage
//
//            // 기타 프로필 정보 저장 또는 업데이트 작업 진행
//            // ...
//
//            dismiss(animated: true)
//        }
        
        if let newImage = selectedImage {
            profileImageView.image = newImage
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func changePhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            selectedImage = pickedImage // 선택한 사진을 임시로 저장
            profileImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

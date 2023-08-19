//
//  AddPostViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/17.
//

import UIKit

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var addPostButton: UIBarButtonItem!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postTextViewHeightConstraint: NSLayoutConstraint!
    
    var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismissRecognizer()
        
        postTextView.layer.borderWidth = 1.0
        postTextView.layer.borderColor = UIColor.systemGray6.cgColor
        postTextView.layer.cornerRadius = 5.0
        postTextView.text = "Write your post here..." // Placeholder text
        postTextView.textColor = UIColor.lightGray
        postTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        if let mainTabBarController = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            mainTabBarController.selectedIndex = 0
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate,
               let window = delegate.window {
                window.rootViewController = mainTabBarController
                window.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Post", message: "Are you sure you want to add this post?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let image = self.pickedImage else {
                let alertController = UIAlertController(title: "Select Image", message: "Please choose an image.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return }
            
            // FIXME: identifier 변경, user의 포스팅 개수 업데이트
            let postCaption = self.postTextView.textColor == .black ? self.postTextView.text : ""
            let newPost = UserPost(thumbnailImage: image, caption: postCaption!, owner: myInfo!)
            posts.insert(newPost, at: 0)
            let index = users.firstIndex(where: {$0.username == myInfo!})
            users[index!].counts.posts += 1
            print(posts.map{$0.id})
            if let mainTabBarController = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                mainTabBarController.selectedIndex = 0
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let delegate = windowScene.delegate as? SceneDelegate,
                   let window = delegate.window {
                    window.rootViewController = mainTabBarController
                    window.makeKeyAndVisible()
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pickImageButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Dismiss
    
    func setupKeyboardDismissRecognizer() {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension AddPostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write your post here..." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your post here..."
            textView.textColor = UIColor.lightGray
        }
        updateTextViewHeight()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.insertText("\n")
            updateTextViewHeight()
            return false
        }
        return true
    }
    
    func updateTextViewHeight() {
        let fittingSize = postTextView.sizeThatFits(CGSize(width: postTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        postTextViewHeightConstraint.constant = fittingSize.height
        view.layoutIfNeeded()
    }
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        view.layoutIfNeeded()
    }
}

//MARK: - UIImagePickerControllerDelegate

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            postImageView.image = editedImage
            pickedImage = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
}


fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

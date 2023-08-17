//
//  EditProfilePageViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/15.
//

import UIKit

class EditProfilePageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    var myProfile: User?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        guard let _myProfile = users.first(where: {$0.username == myInfo?.username}) else { return }
        myProfile = _myProfile
        
        profileImageView.image = _myProfile.profilePhoto
        profileImageView.circleImage = true
        
        firstNameTextField.text = _myProfile.name.first
        lastNameTextField.text = _myProfile.name.last
        userNameTextField.text = _myProfile.username
        bioTextField.text = _myProfile.bio
    }
    
    private func resetUserTextField() {
        userNameTextField.text = ""
        userNameTextField.isUserInteractionEnabled = true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let newUsername = userNameTextField.text else { return }
        
        if newUsername != "", isValidUsername(newUsername) {
            if let newImage = selectedImage {
                profileImageView.image = newImage
                myProfile?.profilePhoto = newImage
            }
            myProfile?.name = (firstNameTextField.text ?? "", lastNameTextField.text ?? "")
            myProfile?.username = newUsername
            myProfile?.bio = bioTextField.text!
            
            if let index = users.firstIndex(where: { $0.username == myInfo?.username }) {
                users[index] = myProfile!
            }
            myInfo = myProfile
            
            dismiss(animated: true)
        } else {
            showInvalidUsernameAlert()
            resetUserTextField()
        }
    }
    
    func isValidUsername(_ username: String) -> Bool {
        return !users.contains(where: {$0.username != myProfile?.username && $0.username == username})
    }

    func showInvalidUsernameAlert() {
        let alert = UIAlertController(title: "Invalid Username", message: "The username is already taken or does not meet the required conditions.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
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
            selectedImage = pickedImage
            profileImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

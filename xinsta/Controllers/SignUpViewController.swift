//
//  SignUpViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/17.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var plusPhotoButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountButton: UIButton!
    
    private var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnView)))

        setupUI()
    }
    
    func setupUI() {
        // FIXME: 사진 버튼에 fill되게 수정하기
        plusPhotoButton.setImage(UIImage(systemName: "person.crop.circle.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.delegate = self
        usernameTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = .lightGray
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        alreadyHaveAccountButton.setAttributedTitle(attributedTitle, for: .normal)
        alreadyHaveAccountButton.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
    }
    
    private func resetInputFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = .lightGray
    }
    
    @objc private func handleTapOnView(_ sender: UITextField) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc private func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func handleTextInputChange() {
        let isFormValid = usernameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .systemBlue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .lightGray
        }
    }
    
    @objc private func handleAlreadyHaveAccount() {
        self.dismiss(animated: true)
    }
    
    @objc private func handleSignUp() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        usernameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.lightGray
        
        let newUser = User(username: username, profilePhoto: profileImage ?? UIImage(systemName: "person.circle.fill")!, password: password)
        if isUsernameTaken(username) {
            self.resetInputFields()
        } else {
            users.append(newUser)
            print(users)
            // TODO: 탭바 컨트롤러 메인페이지로 이동
        }
    }
    
    func isUsernameTaken(_ username: String) -> Bool {
        return users.contains { user in
            return user.username == username
        }
    }
    
    // FIXME: showPassword 클릭 시 키보드 한글로 변경되는 문제
    @IBAction func showPasswordButtonTapped(_ sender: UIButton) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate

extension SignUpViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            profileImage = editedImage
            plusPhotoButton.circleImage = true
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            profileImage = originalImage
        }
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

// TODO: username 입력완료 시 password로 위임하기
// TODO: usernameTextField, passwordTextField 실시간 유효성 검증 기능 추가 (아이디 중복 여부, 패스워드 유효성 여부)
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}


//
//  SignInViewController.swift
//  xinsta
//
//  Created by 이재희 on 2023/08/17.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var dontHaveAccountButton: UIButton!
    
    private var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnView)))

        setupUI()
    }
    
    func setupUI() {
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.delegate = self
        usernameTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        signInButton.layer.cornerRadius = 5
        signInButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signInButton.isEnabled = false
        signInButton.backgroundColor = .lightGray
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        dontHaveAccountButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func resetInputFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        
        signInButton.isEnabled = false
        signInButton.backgroundColor = .lightGray
    }
    
    @objc private func handleTapOnView(_ sender: UITextField) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc private func handleTextInputChange() {
        let isFormValid = usernameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        if isFormValid {
            signInButton.isEnabled = true
            signInButton.backgroundColor = .systemBlue
        } else {
            signInButton.isEnabled = false
            signInButton.backgroundColor = .lightGray
        }
    }
    
    // FIXME: 경고문 화면에 출력하기
    @objc private func handleSignUp() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        usernameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        
        signInButton.isEnabled = false
        signInButton.backgroundColor = UIColor.lightGray
        
        if let existingUser = getUserByUsername(username) {
            if existingUser.password != password {
                print("비밀번호가 일치하지 않습니다.")
                resetInputFields()
            } else {
                myInfo = existingUser
                print("로그인 성공: \(myInfo!)")
                // TODO: 탭바 컨트롤러 메인페이지로 이동
            }
        } else {
            print("존재하지 않는 아이디입니다.")
            resetInputFields()
        }
    }
    
    func getUserByUsername(_ username: String) -> User? {
        return users.first { $0.username == username }
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

// MARK: - UITextFieldDelegate

// TODO: username 입력완료 시 password로 위임하기
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

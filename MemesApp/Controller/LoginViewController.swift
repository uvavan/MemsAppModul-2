//
//  LoginViewController.swift
//  MemesApp
//
//  Created by Admin on 11.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var ibLoginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ibLoginTextField.text = nil
        if (UserFileManager.instance.login != nil) {
            performSegue(withIdentifier: IdentifierName.ShowMemeScrin, sender: nil)
        }
    }
    
    private func setupView() {
        ibLoginTextField.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectRecognizerTap(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func selectRecognizerTap(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == IdentifierName.ShowMemeScrin else { return }
//    }
    
    @IBAction func ibStartButtonPush(_ sender: Any) {
        guard let login = ibLoginTextField.text else {return}
        guard !login.isEmpty else {
            alertShow(title: "Ошибка!", text: "Полле ввода e-mail пустое", currectAnswer: true)
            return
        }
        guard login.isValidEmail else {
            alertShow(title: "Ошибка!", text: "Не корректный e-mail", currectAnswer: true)
            return
        }
        UserFileManager.instance.setLogin(login)
        let path = Utils.pathDirectoryForUser(forUser: login)
        if !FileManager.default.changeCurrentDirectoryPath(path.path) {
            try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
            FileManager.default.changeCurrentDirectoryPath(path.path)
        }
        performSegue(withIdentifier: IdentifierName.ShowMemeScrin, sender: login)
    }
    
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - String valid e-mail
extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}

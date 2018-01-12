//
//  LoginViewController.swift
//  MemesApp
//
//  Created by Admin on 11.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var ibLoginTextField: UITextField!
    
    private let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ibLoginTextField.text = nil
        if keychain.get(KeyNames.LoginName) != nil {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == IdentifierName.ShowMemeScrin, ((segue.destination as? MemesScrinViewController) != nil) else { return }
    }
    
    @IBAction func ibStartButtonPush(_ sender: Any) {
        guard let login = ibLoginTextField.text else {return}
        guard !login.isEmpty else {return}
        guard login.isValidEmail else {return}
        keychain.set(login, forKey: KeyNames.LoginName)
        performSegue(withIdentifier: IdentifierName.ShowMemeScrin, sender: nil)
    }
    
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
}

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

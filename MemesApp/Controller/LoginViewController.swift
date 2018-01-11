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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let string  = keychain.get(KeyNames.LoginName)
        if keychain.get(KeyNames.LoginName) != nil {
            performSegue(withIdentifier: IdentifierName.ShowMemeScrin, sender: nil)
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == IdentifierName.ShowMemeScrin, ((segue.destination as? MemesScrinViewController) != nil) else { return }
//    }
    
    @IBAction func ibStartButtonPush(_ sender: Any) {
        guard let login = ibLoginTextField.text else {return}
        keychain.set(login, forKey: KeyNames.LoginName)
    }
}

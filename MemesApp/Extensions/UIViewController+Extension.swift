//
//  UIViewController+Extension.swift
//  MemesApp
//
//  Created by Admin on 14.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertShow(title: String, text: String, currectAnswer: Bool) {
        let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            if currectAnswer {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

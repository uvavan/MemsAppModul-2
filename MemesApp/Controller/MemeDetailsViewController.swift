//
//  MemeDetailsViewController.swift
//  MemesApp
//
//  Created by Admin on 09.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet private weak var ibTitleLabel: UILabel!
    @IBOutlet private weak var ibMemeImage: UIImageView!
    @IBOutlet private weak var ibLoadActivity: UIActivityIndicatorView!
    
    var meme: Mems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let meme = meme else {
            alertShow(title: "Ошибка!", text: "Данного мема не существует", currectAnswer: true)
            return
        }
        ibTitleLabel.text = meme.name
        ibLoadActivity.startAnimating()
        DataManager.instance.loadMemImageofURL(meme) { [weak self] (image) in
            self?.ibMemeImage.image = image
            self?.ibLoadActivity.stopAnimating()
            self?.ibLoadActivity.isHidden = true
        }
    }
    
    @IBAction func deleteButtonPush(_ sender: Any) {
        if let meme = meme {
            NotificationCenter.default.post(name: .DeleteFavoritesMemes, object: nil, userInfo: [UserInfoNames.userInfoMeme: meme])
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func alertShow(title: String, text: String, currectAnswer: Bool) {
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

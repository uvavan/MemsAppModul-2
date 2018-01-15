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
        UserFileManager.loadImage(meme: meme, user: UserFileManager.login ?? "") { [weak self] (image) in
            DispatchQueue.main.async {
                self?.ibMemeImage.image = image
                self?.ibLoadActivity.stopAnimating()
                self?.ibLoadActivity.isHidden = true
            }
        }
    }
    
    @IBAction func deleteButtonPush(_ sender: Any) {
        if let meme = meme {
            NotificationCenter.default.post(name: .DeleteFavoritesMemes, object: nil, userInfo: [UserInfoNames.userInfoMeme: meme])
        }
        navigationController?.popViewController(animated: true)
    }
    
}

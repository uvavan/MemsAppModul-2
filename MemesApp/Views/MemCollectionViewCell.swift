//
//  CollectionViewCell.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit

class MemCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet private weak var memImage: UIImageView!
    @IBOutlet private weak var nameMemsLabel: UILabel!
    @IBOutlet private weak var ibView: UIView!
    @IBOutlet private weak var ibIndicatorLoad: UIActivityIndicatorView!
    var meme: Mems?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateImage(_ meme: Mems, login: String? = nil) {
        let clouser: ((UIImage?) -> Void) = { [weak self] (image) in
            DispatchQueue.main.async {
                guard self!.meme?.id == meme.id else { return }
                self?.memImage.image = image
                self?.ibIndicatorLoad.stopAnimating()
                self?.ibIndicatorLoad.isHidden = true
            }
        }
        self.meme = meme
        memImage.image = #imageLiteral(resourceName: "image2@")
        ibIndicatorLoad.startAnimating()
        ibIndicatorLoad.isHidden = false
        if let login = login {
            UserFileManager.loadImage(meme: meme, user: login, completionHandler: clouser)
        } else {
            DataManager.instance.loadMemImageofURL(meme, completionHandler: clouser)
        }
    }
    
    func updateName(_ name: String) {
        nameMemsLabel.text = name
    }
    
}

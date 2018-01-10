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
        // Initialization code
    }
    
    func uupdateImage(_ meme: Mems) {
        self.meme = meme
        DataManager.instance.loadMemImageofURL(meme) { [weak self] (image) in
            guard self!.meme?.id == meme.id else { return }
            self?.memImage.image = image
            self?.ibIndicatorLoad.stopAnimating()
            self?.ibIndicatorLoad.isHidden = true
        }
    }
    
   /* func updateImage(_ image: UIImage? = nil) {
        if image == nil {
            ibIndicatorLoad.startAnimating()
            ibView.isHidden = false
        } else {
            ibIndicatorLoad.stopAnimating()
            ibView.isHidden = true
        }
        memImage.image = image == nil ? #imageLiteral(resourceName: "images") : image
    }*/
    
    func updateName(_ name: String) {
        nameMemsLabel.text = name
    }
    
}

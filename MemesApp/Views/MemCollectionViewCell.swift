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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(name: String, image: UIImage? = nil) {
        memImage.image = image
        nameMemsLabel.text = name
    }

}

//
//  MemsViewController.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit
import PKHUD

class MemsListViewController: UICollectionViewController {
    
    //private var memsList: [Mems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(MemCollectionViewCell.self)
        HUD.showProgress()
        DataManager.instance.loadMemsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(loadMemOfMemsList), name: .MemsListLoaded, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func loadMemOfMemsList() {
        HUD.hide()
        collectionView?.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension MemsListViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.instance.memsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let mem = DataManager.instance.memsList[indexPath.row]
        cell.updateName(mem.name)
        cell.uupdateImage(mem)
//        DataManager.instance.loadMemImageofURL(mem) { (image) in
//            cell.updateImage(image)
//            cell.setNeedsLayout()
//        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mame = DataManager.instance.memsList[indexPath.row]
        NotificationCenter.default.post(name: .AddFavoritesMemes, object: nil, userInfo: [UserInfoNames.userInfoMeme: mame])
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MemsListViewController: UICollectionViewDelegateFlowLayout {
    private var minimumItemSpacing: CGFloat {return 10}
    private var sectionsInsest: UIEdgeInsets {return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)}
    private var itemsPerRow: CGFloat {return 3}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionsInsest.left + sectionsInsest.right + minimumItemSpacing * (itemsPerRow - 1)
        let availabelWidth = collectionView.bounds.width - paddingSpace
        let itemWidth = availabelWidth / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionsInsest
    }
}

//
//  MemsScrinViewController.swift
//  MemesApp
//
//  Created by Admin on 09.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit
import PKHUD
import KeychainSwift

class MemesScrinViewController: UICollectionViewController {

    private var favoritesMemes: [Mems] = []
    private var login = ""
   // private var user = UserMemesApp(login:)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(MemCollectionViewCell.self)
        HUD.showProgress()
        addNotification()
        loadUserInfo()
    }
    
    private func loadUserInfo() {
        guard let login = UserFileManager.login else {return}
        self.login = login
        guard let memes = UserFileManager.loadMemesListFromUserDefaults(login: login) else {
            HUD.hide()
            return
        }
        favoritesMemes = memes
        HUD.hide()
        collectionView?.reloadData()
    }
    
    private func addNotification () {
        NotificationCenter.default.addObserver(self, selector: #selector(addFavoritesMeme(_ :)), name: .AddFavoritesMemes, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteFavoritesMeme(_:)), name: .DeleteFavoritesMemes, object: nil)
    }
    
    @objc private func addFavoritesMeme(_ notification: NSNotification) {
        guard let meme = notification.userInfo![UserInfoNames.userInfoMeme] as? Mems else {return}
        guard favoritesMemes.filter({ [meme] in
            return $0.id == meme.id
        }).isEmpty else {return}
        favoritesMemes.append(Mems(id: meme.id, name: meme.name, url: meme.url))
        UserFileManager.saveImage(meme: meme, user: login)
        UserFileManager.saveMemesListToUserDefaults(memes: favoritesMemes, login: login)
        collectionView?.reloadData()
    }
    
    @objc private func deleteFavoritesMeme(_ notification: NSNotification) {
        guard let meme = notification.userInfo![UserInfoNames.userInfoMeme] as? Mems else {return}
        for (index, item) in favoritesMemes.enumerated() where item.id == meme.id {
            favoritesMemes.remove(at: index)
        }
        UserFileManager.deleteImage(meme: meme, login: login)
        UserFileManager.saveMemesListToUserDefaults(memes: favoritesMemes, login: login)
        collectionView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == IdentifierName.ShowDetails, let destVC = segue.destination as? MemeDetailsViewController else { return }
        guard let indexPath = sender as? IndexPath else { return }
        destVC.meme = favoritesMemes[indexPath.item]
    }
    
    @IBAction private func logoutPressed(_ sender: Any) {
        let keychain = KeychainSwift()
        keychain.delete(KeyNames.LoginName)
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension MemesScrinViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let mem = favoritesMemes[indexPath.item]
        cell.updateName(mem.name)
        cell.updateImage(mem, login: login)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: IdentifierName.ShowDetails, sender: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MemesScrinViewController: UICollectionViewDelegateFlowLayout {
    private var minimumItemSpacing: CGFloat {return 10}
    private var sectionsInsest: UIEdgeInsets {return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)}
    private var itemsPerRow: CGFloat {return 2}
    
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

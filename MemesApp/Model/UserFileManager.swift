//
//  UserFileManager.swift
//  MemesApp
//
//  Created by Admin on 14.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit
import KeychainSwift

final class UserFileManager {
    static let instance = UserFileManager()
    private init() { }
    
    var login: String? {
        let keychain = KeychainSwift()
        return keychain.get(KeyNames.LoginName)
    }
    
    func setLogin(_ login: String) {
        let keychain = KeychainSwift()
        keychain.set(login, forKey: KeyNames.LoginName)
    }
    
    func saveImage(meme: Mems, user login: String) {
        let imagePath = Utils.pathInDocument(withComponent: meme.name, forUsser: login).path
        DataManager.instance.loadMemImageofURL(meme) { (image) in
            guard let image = image else {return}
            DispatchQueue.global().async {
                let imageData = UIImagePNGRepresentation(image)
                FileManager.default.createFile(atPath: imagePath, contents: imageData)
            }
        }
    }
    
    func loadImage(meme: Mems, user login: String, completionHandler: @escaping ((UIImage?) -> Void)) {
        let imagePath = Utils.pathInDocument(withComponent: meme.name, forUsser: login).path
        if FileManager.default.fileExists(atPath: imagePath) {
            DispatchQueue.global().async { [imagePath] in
                guard let image = UIImage(contentsOfFile: imagePath) else {return}
                completionHandler(image)
            }
        } else {
            DataManager.instance.loadMemImageofURL(meme, completionHandler: completionHandler)
        }
    }
    
    func deleteImage(meme: Mems, login: String) {
        let imagePath = Utils.pathInDocument(withComponent: meme.name, forUsser: login).path
        NotificationCenter.default.post(name: .DeleteFavoritesMemes, object: nil, userInfo: [UserInfoNames.userInfoMeme: meme])
        guard FileManager.default.fileExists(atPath: imagePath) else {return}
        try? FileManager.default.removeItem(atPath: imagePath)
    }
    
    func saveMemesListToUserDefaults(memes: [Mems], login: String) {
        try? UserDefaults.standard.set(PropertyListEncoder().encode(memes), forKey: login)
    }
    
    func loadMemesListFromUserDefaults(login: String) -> [Mems]? {
        guard let encoded = UserDefaults.standard.object(forKey: login) as? Data else {return nil}
        return try? PropertyListDecoder().decode([Mems].self, from: encoded)
    }
}

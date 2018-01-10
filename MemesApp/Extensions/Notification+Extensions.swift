//
//  Notification+Extensions.swift
//  MemesApp
//
//  Created by Admin on 05.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let MemsListLoaded = Notification.Name("MemsListLoaded")
    static let DidFailLoadMemsList = Notification.Name("DidFailLoadMemsList")
    
    static let MemLoaded = Notification.Name("MemLoaded")
    static let DidFailLoadMem = Notification.Name("DidFailLoadMem")
    
    static let AddFavoritesMemes = Notification.Name("AddFavoritesMemes")
    static let DeleteFavoritesMemes = Notification.Name("DeleteFavoritesMemes")
    
    static let NeedUpdateCell = Notification.Name("NeedUpdateCell")
}

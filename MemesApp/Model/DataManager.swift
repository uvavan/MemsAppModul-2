//
//  DataManager.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import Foundation
import SwiftyJSON

final class DataManager {
    static let instance = DataManager()
    
    private(set) var mems: [Mems] = []
    
    func loadMemsList() {
        NetworkService.request(endpoint: MemsEndpoint.memsList) { [weak self] response in
            guard let value = response.value else {
                // TODO: add notification error
                return
            }
            let json = JSON(value)
            // TODO: add Notification ok data
        }
    }
    
}

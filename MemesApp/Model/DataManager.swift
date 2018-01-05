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
    
    private(set) var memsList: [Mems] = []
    
    func loadMemsList() {
        NetworkService.request(endpoint: MemesEndpoint.memesList) { [weak self] response in
            guard let value = response.value else {
                // TODO: add notification error
                return
            }
            let json = JSON(value)
            self?.memsList = []
            guard let jsonArrayMems = json["data"]["memes"].array else {
                // TODO: add notification error
                return
            }
            for item in jsonArrayMems {
                guard let mem = Mems(json: item) else {continue}
                self?.memsList.append(mem)
            }
            self?.postMainQueueNotification(withName: .MemsListLoaded)
        }
    }
    
    private func postMainQueueNotification(withName name: Notification.Name, userInfo: [AnyHashable: Any]? = nil ) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
        }
    }
    
}

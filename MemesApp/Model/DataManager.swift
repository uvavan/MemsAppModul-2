//
//  DataManager.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import UIKit
import SwiftyJSON

final class DataManager {
    static let instance = DataManager()
    private init() { }
    
    private(set) var memsList: [Mems] = []
   // private var memesImage: [String: UIImage] = [:]
    
    func loadMemsList() {
        guard memsList.isEmpty else {
            postMainQueueNotification(withName: .MemsListLoaded)
            return
        }
        NetworkService.request(endpoint: MemesEndpoint.memesList) { [weak self] response in
            guard let value = response.value else {
                self?.postMainQueueNotification(withName: .DidFailLoadMemsList)
                return
            }
            let json = JSON(value)
            self?.memsList = []
            guard let jsonArrayMems = json["data"]["memes"].array else {
                self?.postMainQueueNotification(withName: .DidFailLoadMemsList)
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
    
    func loadMemImageofURL(_ mem: Mems, completionHandler: @escaping ((UIImage?) -> Void)) {
        let imageStringUrl = mem.url
        guard let url = URL(string: imageStringUrl) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                return
            }
            let image = UIImage (data: imageData)
            completionHandler(image)
        }
    }
 
}

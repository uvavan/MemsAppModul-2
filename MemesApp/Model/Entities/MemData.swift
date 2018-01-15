//
//  MemData.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Mems: Codable {
    let id: String
    let name: String
    let url: String
}

extension Mems {
    init?(json: JSON) {
        guard let id = json["id"].string,
            let name = json["name"].string,
            let url = json["url"].string
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.url = url
    }
}

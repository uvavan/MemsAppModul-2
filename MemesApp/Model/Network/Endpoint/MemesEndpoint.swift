//
//  MemsEndpoint.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import Foundation
import Alamofire

enum MemesEndpoint: Endpoint {
    case memesList
    case memes(memes: Mems)
}

// MARK: - Endpoint
extension MemesEndpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .memesList:
            return "https://api.imgflip.com/get_memes"
        case .memes(let mem):
            return mem.url
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

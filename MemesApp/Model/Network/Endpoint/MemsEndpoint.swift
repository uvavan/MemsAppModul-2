//
//  MemsEndpoint.swift
//  MemesApp
//
//  Created by Admin on 04.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import Foundation
import Alamofire

enum MemsEndpoint: Endpoint {
    case memsList
    case mems(mems: Mems)
}

// MARK: - Endpoint
extension MemsEndpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .memsList:
            return "https://api.imgflip.com/"
        case .mems(let mems):
            return mems.url
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

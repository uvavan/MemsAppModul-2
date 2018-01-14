//
//  Utils.swift
//  MemesApp
//
//  Created by Admin on 14.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import Foundation

struct Utils {
    static var directoryURL: URL {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Something strange")
        }
        return path
    }
    
    static func pathDirectoryForUser(forUser login: String) -> URL {
        return directoryURL.appendingPathComponent(login)
    }

    static func pathInDocument(withComponent component: String, forUsser login: String) -> URL {
        let path = pathDirectoryForUser(forUser: login)
        return path.appendingPathComponent(component)
    }
}

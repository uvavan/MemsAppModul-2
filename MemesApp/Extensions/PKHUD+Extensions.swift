//
//  PKHUD+Extensions.swift
//  MemesApp
//
//  Created by Admin on 05.01.2018.
//  Copyright © 2018 Bioprom. All rights reserved.
//

import PKHUD

extension HUD {
    static func showProgress(hideTimeout: TimeInterval = 30) {
        self.show(.progress)
        self.hide(afterDelay: hideTimeout)
    }
}

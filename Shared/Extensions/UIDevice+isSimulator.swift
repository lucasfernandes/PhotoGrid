//
//  UIDevice+isSimulator.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 02/03/21.
//

import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if IOS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
}

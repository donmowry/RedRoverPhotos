//
//  Rover.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import RedRoverAPI
import SwiftUI

extension Rovers {
    func image() -> Image {
        Image(self.rawValue)
    }
    
    func name() -> String {
        rawValue
    }
}


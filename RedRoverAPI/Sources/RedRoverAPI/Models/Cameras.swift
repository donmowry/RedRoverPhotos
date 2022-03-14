//
//  Cameras.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

@frozen public enum Cameras: String, CaseIterable, Codable {
    case FHAZ
    case RHAZ
    case MAST
    case CHEMCAM
    case MAHLI
    case MARDI
    case NAVCAM
    case PANCAM
    case MINITES
    case ENTRY
     
    public func localizedName() -> String {
        Bundle.module.localizedString(forKey: rawValue, value: rawValue, table: "RedRoverAPI")
    }
}

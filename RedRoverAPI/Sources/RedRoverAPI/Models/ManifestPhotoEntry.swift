//
//  Photo.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

@frozen public struct ManifestPhotoEntry: Codable {
    public var sol: Int
    public var earthDate: Date
    public var totalPhotos: Int
    public var cameras: [Cameras]
}

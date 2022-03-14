//
//  PhotoManifest.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

struct PhotoManifestWrapper: Codable {
    var photoManifest: PhotoManifest
}

@frozen public struct PhotoManifest: Codable {
    public var name: String
    public var landingDate: Date
    public var launchDate: Date
    public var maxSol: Int
    public var maxDate: Date
    public var totalPhotos: Int
    public var photos: [ManifestPhotoEntry]
    
    public static let empty = PhotoManifest(name: "",
                                            landingDate: Date.distantPast,
                                            launchDate: Date.distantPast,
                                            maxSol: 0,
                                            maxDate: Date.distantFuture,
                                            totalPhotos: 0,
                                            photos: [])
}

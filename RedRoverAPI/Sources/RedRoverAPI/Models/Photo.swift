//
//  Photo.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

struct PhotosWrapper: Codable {
    var photos: [Photo]
}


@frozen public struct Photo: Codable {
    @frozen public struct Camera: Codable {
        public var id: Int
        public var name: String
        public var roverId: Int
        public var fullName: String
    }
    
    @frozen public struct Rover: Codable {
        public var id: Int
        public var name: String
        public var landingDate: Date
        public var launchDate: Date
        public var status: String
    }
    
    public var id: Int
    public var sol: Int
    public var camera: Photo.Camera
    public var imgSrc: String
    public var earthDate: Date
    public var rover: Rover
}

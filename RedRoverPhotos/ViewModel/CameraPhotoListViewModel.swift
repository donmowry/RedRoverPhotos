//
//  CameraPhotoListViewModel.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import SwiftUI
import Cache
import RedRoverAPI

@MainActor
class CameraPhotoListViewModel: ObservableObject {
    let apiClient: RedRoverAPIClient
    let rover: Rovers
    let camera: Cameras
    let sol: Int
    
    private var cacheKey: String {
        "\(rover.rawValue)|\(camera.rawValue)|\(sol)"
    }
    
    @Published var photos = [Photo]()
    
    static private var cache: Storage<String, [Photo]> = {
        let diskConfig = DiskConfig(name: "Photo",
                                    expiry: .date(Date().addingTimeInterval(60 * 60 * 24 * 3)))
        let memoryConfig = MemoryConfig(countLimit: 1000, totalCostLimit: 0)
        
        do {
            return try Storage<String, [Photo]>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: [Photo].self)
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    init(rover: Rovers, camera: Cameras, sol: Int, apiClient: RedRoverAPIClient) {
        self.rover = rover
        self.camera = camera
        self.sol = sol
        self.apiClient = apiClient
        if let cachedPhotos = try? Self.cache.object(forKey: cacheKey) {
            self.set(photos: cachedPhotos)
        }
    }
    
    private func set(photos: [Photo]) {
        self.photos = photos.sorted(by: { $0.sol > $1.sol })
    }
    
    func refresh() async {
        let photosResult = await apiClient.photos(forRover: rover, camera: camera, sol: sol)
        
        switch photosResult {
        case .success(let photos):
            self.set(photos: photos)
            try? Self.cache.setObject(photos, forKey: cacheKey)
        case .failure(let error):
            print(error)
            return
        }
    }
}

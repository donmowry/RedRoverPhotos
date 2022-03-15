//
//  RoverViewModel.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import SwiftUI
import Cache
import RedRoverAPI

@MainActor
class RoverViewModel: ObservableObject {
    let apiClient: RedRoverAPIClient
    let rover: Rovers
    
    @Published var photoManifest: PhotoManifest = PhotoManifest.empty
    @Published var photos = [ManifestPhotoEntry]()
    @Published var hasData: Bool = false
    @Published var errorMessage: String? = nil
    
    var isPresentingAlert: Binding<Bool> {
        Binding<Bool>(get: {
            self.errorMessage != nil
        }, set: { newValue in
            guard !newValue else {
                return
            }
            self.errorMessage = nil
        })
    }

    
    static private var cache: Storage<String, PhotoManifest> = {
        let diskConfig = DiskConfig(name: "PhotoManifest",
                                    expiry: .date(Date().addingTimeInterval(60 * 60 * 24 * 3)))
        let memoryConfig = MemoryConfig(countLimit: 3, totalCostLimit: 0)
        
        do {
            return try Storage<String, PhotoManifest>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: PhotoManifest.self)
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    init(rover: Rovers, apiClient: RedRoverAPIClient) {
        self.rover = rover
        self.apiClient = apiClient
        if let cachedManifest = try? Self.cache.object(forKey: rover.rawValue) {
            self.photoManifest = cachedManifest
            self.hasData = true
            self.set(photos: cachedManifest.photos)
        }
    }
    
    private func set(photos: [ManifestPhotoEntry]) {
        self.photos = photos.sorted(by: { $0.sol > $1.sol })
        
    }
    
    func refresh() async {
        let manifestResult = await apiClient.photoManifest(forRover: rover)
        
        switch manifestResult {
        case .success(let photoManifest):
            self.photoManifest = photoManifest
            self.hasData = true
            self.set(photos: photoManifest.photos)
            try? Self.cache.setObject(photoManifest, forKey: rover.rawValue)
        case .failure(let error):
            switch error {
            case .serverError(let serverMessageError):
                errorMessage = serverMessageError.message
            case .dataFetchError(let internalError):
                errorMessage = "There was a problem fetching data"
                if let internalError = internalError {
                    errorMessage = internalError.localizedDescription
                }
            case .incorrectURL(let url):
                errorMessage = "There was a problem with the url: \(url)"
            case .queryItemError(let queryItem):
                errorMessage = "There was a problem with the queryItem: \(queryItem)"
            }
            return
        }
    }
}

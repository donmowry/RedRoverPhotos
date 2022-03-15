//
//  RemoteImageModel.swift
//  RedRoverPhotos
//
//  Created by Don on 3/15/22.
//

import SwiftUI
import Cache

@MainActor
class RemoteImageModel: ObservableObject {
    @Published var image: UIImage?
    
    private let urlString: String?
    
    static private var cache: Storage<String, UIImage> = {
        let diskConfig = DiskConfig(name: "RemoteImage",
                                    expiry: .date(Date().addingTimeInterval(60 * 60 * 24 * 3)))
        let memoryConfig = MemoryConfig(countLimit: 3, totalCostLimit: 0)
        
        do {
            return try Storage<String, UIImage>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forImage()
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    init(urlString: String?) {
        self.urlString = urlString
        if let urlString = urlString,
           let cachedImage = try? Self.cache.object(forKey: urlString) {
            self.image = cachedImage
        }
    }
    
    func loadImage() async {
        guard let urlString = urlString,
          let url = URL(string: urlString) else {
              return
          }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            guard let image = UIImage(data: data) else {
                return
            }
            self.image = image
            try? Self.cache.setObject(image, forKey: urlString)
        }
        catch { }
    }
}

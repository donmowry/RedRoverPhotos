//
//  RedRoverAPIClient+Creation.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import Foundation
import RedRoverAPI

extension RedRoverAPIClient {
    
    /// By adding an entry in .xcconfig for API\_KEY, you can use your own NASA API key
    /// By default this class uses the rate-limited key "DEMO\_KEY"
    static func create() -> RedRoverAPIClient {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "DEMO_KEY"
        return RedRoverAPIClient(apiKey: apiKey)
    }
}

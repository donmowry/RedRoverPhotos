//
//  RedRoverPhotosApp.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import SwiftUI
import RedRoverAPI

@main
struct RedRoverPhotosApp: App {
    @StateObject var apiClient = RedRoverAPIClient.create()
    
    var body: some Scene {
        WindowGroup {
            RoverListView()
                .environmentObject(apiClient)
        }
        
    }
}

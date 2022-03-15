//
//  PhotoListView.swift
//  RedRoverPhotos
//
//  Created by Don on 3/14/22.
//

import SwiftUI
import RedRoverAPI

struct RoverSolView: View {
    @EnvironmentObject var apiClient: RedRoverAPIClient
    var rover: Rovers
    var manifestPhotoEntry: ManifestPhotoEntry
    
    var body: some View {
        HStack {
            Text("Sol")
            Text("\(manifestPhotoEntry.sol)")
        }
        List {
            ForEach(manifestPhotoEntry.cameras, id: \.rawValue) { camera in
                NavigationLink {
                    CameraPhotoListView(cameraPhotoListViewModel:
                                            CameraPhotoListViewModel(rover: rover,
                                                                     camera: camera,
                                                                     sol: manifestPhotoEntry.sol,
                                                                     apiClient: apiClient))
                } label: {
                    Text(camera.localizedName())
                }
                
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        RoverSolView(rover: .spirit,
                     manifestPhotoEntry: ManifestPhotoEntry.empty)
    }
}

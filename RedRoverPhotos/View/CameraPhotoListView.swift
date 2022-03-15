//
//  CameraPhotoListView.swift
//  RedRoverPhotos
//
//  Created by Don on 3/14/22.
//

import SwiftUI
import RedRoverAPI

struct CameraPhotoListView: View {
    @ObservedObject var cameraPhotoListViewModel: CameraPhotoListViewModel
    
    var body: some View {
        List {
            ForEach(cameraPhotoListViewModel.photos) { photo in
                NavigationLink {
                    RemoteImage(urlString: photo.imgSrc)
                } label: {
                    HStack {
                        RemoteImage(urlString: photo.imgSrc)
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                    VStack {
                        Text(photo.earthDate, style: .date)
                    }
                    .badge(photo.id)
                }
            }
        }
        .redacted(reason: cameraPhotoListViewModel.photos.count == 0 ? .placeholder : [])
        .refreshable {
            await cameraPhotoListViewModel.refresh()
        }
        .navigationBarTitle("", displayMode: .inline)
        .task {
            await cameraPhotoListViewModel.refresh()
        }
    }
}

struct CameraPhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPhotoListView(cameraPhotoListViewModel:
                                CameraPhotoListViewModel(rover: .opportunity,
                                                         camera: .CHEMCAM,
                                                         sol: 0,
                                                         apiClient: RedRoverAPIClient.create()))
    }
}

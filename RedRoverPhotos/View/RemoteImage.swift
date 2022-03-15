//
//  RemoteImage.swift
//  RedRoverPhotos
//
//  Created by Don on 3/15/22.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var remoteImageModel: RemoteImageModel

    init(urlString: String?) {
        remoteImageModel = RemoteImageModel(urlString: urlString)
    }
    
    var body: some View {
        if let image = remoteImageModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        else {
            Rectangle()
                .redacted(reason: .placeholder)
                .task {
                    await remoteImageModel.loadImage()
                }
        }
    }
    
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(urlString: "")
    }
}


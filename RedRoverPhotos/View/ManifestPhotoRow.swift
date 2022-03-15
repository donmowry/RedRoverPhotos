//
//  ManifestPhotoRow.swift
//  RedRoverPhotos
//
//  Created by Don on 3/14/22.
//

import SwiftUI
import RedRoverAPI

struct ManifestPhotoRow: View {
    var manifestPhotoEntry: ManifestPhotoEntry
    
    var body: some View {
        HStack {
            Text("Sol")
            Text("\(manifestPhotoEntry.sol)")
        }
        .badge(manifestPhotoEntry.totalPhotos)
    }
}

struct ManifestPhotoRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ManifestPhotoRow(manifestPhotoEntry: .empty)
        }
    }
}

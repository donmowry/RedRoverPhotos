//
//  RoverDetailView.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import SwiftUI
import RedRoverAPI

struct RoverDetailView: View {
    @ObservedObject var viewModel: RoverViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.photoManifest.name)
        }
        .task {
            await viewModel.refresh()
        }
    }
}

struct RoverDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoverDetailView(viewModel: RoverViewModel(rover: .opportunity, apiClient: RedRoverAPIClient.create()))
    }
}

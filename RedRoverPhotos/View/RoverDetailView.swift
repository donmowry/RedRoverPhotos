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
        VStack {
            Text(viewModel.photoManifest.name)
                .textCase(.uppercase)
                .font(.largeTitle.bold())
            viewModel.rover.image()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            Group {
                HStack {
                    Text("🚀  Launch Date ")
                        .font(.caption)
                    Text(viewModel.photoManifest.launchDate, style: .date)
                        .font(.caption)
                    Spacer()
                }
                HStack {
                    Text("🪂  Landing Date")
                        .font(.caption)
                    Text(viewModel.photoManifest.landingDate, style: .date)
                        .font(.caption)
                    Spacer()
                }
            }
            .padding(.leading)
            List {
                ForEach(viewModel.photos, id: \.sol) { manifestPhotoEntry in
                    NavigationLink {
                        RoverSolView(rover: viewModel.rover,
                                     manifestPhotoEntry: manifestPhotoEntry)
                    } label: {
                        ManifestPhotoRow(manifestPhotoEntry: manifestPhotoEntry)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .refreshable {
                await viewModel.refresh()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
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

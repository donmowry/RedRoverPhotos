//
//  RoverListView.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import SwiftUI
import RedRoverAPI

struct RoverListView: View {
    @EnvironmentObject var apiClient: RedRoverAPIClient
    let roverListModel = RoverViewListViewModel()

    var body: some View {
        NavigationView {
            List(roverListModel.rovers, id: \.rawValue) { rover in
                NavigationLink {
                    RoverDetailView(viewModel: RoverViewModel(rover: rover, apiClient: apiClient))
                } label: {
                    RoverRowView(rover: rover)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Mars Rovers")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RoverListView()
    }
}

//
//  RoverViewListViewModel.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import Combine
import RedRoverAPI

struct RoverViewListViewModel {
    var rovers: [Rovers] {
        Rovers.allCases.sorted()
    }
}

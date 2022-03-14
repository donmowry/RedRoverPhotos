//
//  RoverRowView.swift
//  RedRoverPhotos
//
//  Created by Don on 3/13/22.
//

import SwiftUI
import RedRoverAPI

struct RoverRowView: View {
    var rover: Rovers
    
    var body: some View {
        HStack {
            rover.image()
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .shadow(color: .black, radius: 2.0, x: 1.0, y: 1.0)
                .padding(8.0)
            Text(rover.name())
                .font(.headline)
            Spacer()
        }
    }
}

struct RoverRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoverRowView(rover: Rovers.curiosity)
    }
}

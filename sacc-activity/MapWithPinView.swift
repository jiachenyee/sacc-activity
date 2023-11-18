//
//  MapWithPinView.swift
//  jiachen group fun
//
//  Created by Kai Quan Tay on 18/11/23.
//

import SwiftUI
import MapKit

struct MapWithPinView: View {
    let coordinate: (Double, Double)

    var body: some View {
        Map(
            initialPosition: .region(createRegion()),
            interactionModes: []
        ) {
            Marker(coordinate: CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)) {
                Text("Pin")
            }
        }
        .overlay(alignment: .top) {
            Text("\(coordinate.0), \(coordinate.1)")
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.thinMaterial)
                }
                .padding(.top, 32-10)
                .font(.system(size: 32))
        }
    }

    private func createRegion() -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: center, span: span)
    }
}

#Preview {
    MapWithPinView(coordinate: (1.2984582480995834, 103.78851110295764)) // Example coordinates for San Francisco
}

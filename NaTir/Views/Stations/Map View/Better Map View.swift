//
//  Better Map View.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable
{
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var locationManager: LocationManager
    
    @State var region: MKCoordinateRegion

    class Coordinator: NSObject, MKMapViewDelegate
    {
        var parent: MapView

        init(_ parent: MapView)
        {
            self.parent = parent
        }

        /// showing annotation on the map
        func mapView(_: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
        {
            guard let annotation = annotation as? LandmarkAnnotation else { return nil }
            return AnnotationView(annotation: annotation, reuseIdentifier: AnnotationView.ReuseID)
        }
    }

    func makeCoordinator() -> Coordinator
    {
        MapView.Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView
    {
        ///  creating a map
        let view = MKMapView()
        /// connecting delegate with the map
        view.delegate = context.coordinator
        view.setRegion(region, animated: true)
        view.mapType = .mutedStandard
        view.showsUserLocation = true

        for points in appState.stations
        {
            let annotation = LandmarkAnnotation(coordinate: points.coordinate!, title: points.name)
            view.addAnnotation(annotation)
        }

        return view
    }

    func updateUIView(_ mapView: MKMapView, context: Context)
    {
        mapView.setRegion(locationManager.region, animated: true)
    }
}

class LandmarkAnnotation: NSObject, MKAnnotation
{
    let coordinate: CLLocationCoordinate2D
    let title: String?
    init(
        coordinate: CLLocationCoordinate2D,
        title: String
    )
    {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}

/// here posible to customize annotation view
let clusterID = "clustering"

class AnnotationView: MKMarkerAnnotationView
{
    static let ReuseID = "cultureAnnotation"

    /// setting the key for clustering annotations
    override init(annotation: MKAnnotation?, reuseIdentifier: String?)
    {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        clusteringIdentifier = clusterID
        glyphImage = UIImage(systemName: "train.side.front.car")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay()
    {
        super.prepareForDisplay()
        displayPriority = .defaultLow
        
    }
}

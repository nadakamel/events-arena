//
//  EventDetailsViewController.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import UIKit
import MapKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var event: EventDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOutlets()
    }
    
    func loadOutlets() {
        if let mediaURL = event.cover {
            coverImageView.kf.indicatorType = .activity
            coverImageView.kf.setImage(with: URL(string: mediaURL))
        }
        nameLabel.text = event.name
        startDateLabel.text = event.startDate?.toDate()?.toString()
        descriptionLabel.text = event.eventDetailDescription
        guard let latitude = event.latitude, let longitude = event.longitude else {
            mapView.isHidden = true
            return
        }
        let coordinate = CLLocation(latitude: Double(latitude) ?? 0,
                                    longitude: Double(longitude) ?? 0)
        mapView.centerToLocation(coordinate)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0,
                                                       longitude: Double(longitude) ?? 0)
        mapView.addAnnotation(annotation)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 100000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

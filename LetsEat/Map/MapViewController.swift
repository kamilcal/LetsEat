//
//  MapViewController.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    private let manager = MapDataManager()
    var selectedRestaurant: RestaurantItem?
    
//MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

//MARK: - Action

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        default:
            print("Segue not added")
        }
    }
 
}
   

//MARK: - setupUI

private extension MapViewController {
    
    func initialize() {
        mapView.delegate = self
        manager.fetch { annotations in
            setupMap(annotations)
        }
    }
    
    func setupMap(_ annotations: [RestaurantItem]){
        mapView.setRegion(manager.initialRegion(letDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailTableViewController,
           let restaurant = selectedRestaurant { viewController.selectedRestaurant = restaurant
        }
    }
}

//MARK: - Delegate Methods

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else {
            return
        }
        selectedRestaurant = annotation as? RestaurantItem
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "custompin"
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        let annotationView: MKAnnotationView
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        annotationView.canShowCallout = true
           if let image = UIImage(named:
                "custom-annotation") {
                    annotationView.image = image
                    annotationView.centerOffset = CGPoint(
                    x: -image.size.width / 2,
                    y: -image.size.height / 2)
           }
           return annotationView
        }
    
}


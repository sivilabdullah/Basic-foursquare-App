//
//  ShowMapViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 20.05.2023.
//

import UIKit
import MapKit
import Parse
class ShowMapViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var detailMapKitView: MKMapView!
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var selectedPlaceId = ""
    var selectedAnnotationTitle = ""
    var selectedAnnotationType = ""
    override func viewDidLoad() {
        super.viewDidLoad()

       getData()
        detailMapKitView.delegate = self
    }
    
    
    
    func getData(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: selectedPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                AlertManager.alert(title: "Map error", message: error?.localizedDescription ?? "undefined error", vc: self)
            }else{
                //Objects
                if objects != nil{
                    let chosenObject = objects![0]
                    if let placeLatitude = chosenObject.object(forKey: "latitude") as? String{
                        if let placeLatitudeDouble = Double(placeLatitude){
                            self.chosenLatitude = placeLatitudeDouble
                            
                        }
                    }
                    if let placeLongitude = chosenObject.object(forKey: "longitude") as? String{
                        if let placeLongitudeDouble = Double(placeLongitude){
                            self.chosenLongitude = placeLongitudeDouble
                            
                        }
                    }
                }
                // Maps
                
                let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                let region = MKCoordinateRegion(center: location, span: span)
                self.detailMapKitView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.selectedAnnotationTitle
                annotation.subtitle = self.selectedAnnotationType
                self.detailMapKitView.addAnnotation(annotation)
                
            }
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reusId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusId)
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reusId)
           //pinbutton show
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    //after tapped button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks{
                    if placemark.count > 0 {
                        let mkPlacemark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlacemark)
                        mapItem.name = self.selectedAnnotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
}

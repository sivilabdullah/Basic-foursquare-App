//
//  MapViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 20.05.2023.
//

import UIKit
import MapKit
import CoreLocation
import Parse
class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var mapKitView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bar button
        let navBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: nil)
        saveBtn = navBarButton
        
        //delegations
        mapKitView.delegate = self
        locationManager.delegate = self
        
        //location islemleri
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //pin
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocations(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapKitView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseLocations(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let touchPoint = gestureRecognizer.location(in : self.mapKitView)
            let touchedCoordinates = mapKitView.convert(touchPoint, toCoordinateFrom: mapKitView)
            
            placeInfos.sharedInstance.placeLatitude = String(touchedCoordinates.latitude)
            placeInfos.sharedInstance.placeLongitude  = String(touchedCoordinates.longitude)
            
            //create pin
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = placeInfos.sharedInstance.placeName
            annotation.subtitle = placeInfos.sharedInstance.placeType
            self.mapKitView.addAnnotation(annotation)
        }
        
    }
    
    //lokasyon guncellenirse calisacak fonksiyon
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapKitView.setRegion(region, animated: true)
    }
    
   //save button
    @IBAction func saveBtnClicked(_ sender: UIBarButtonItem) {
        let placeModel = placeInfos.sharedInstance
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["description"] = placeModel.description
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5){
            let id = UUID()
            object["image"] = PFFileObject(name: "\(id).jpeg", data: imageData)
        }
        object.saveInBackground { success, error in
            if error != nil {
                AlertManager.alert(title: "database error", message: error?.localizedDescription ?? "undefined error", vc: self)
            }else {
                self.performSegue(withIdentifier: "fromMapViewToListView", sender: nil)
            }
        }
        
    }
    
}

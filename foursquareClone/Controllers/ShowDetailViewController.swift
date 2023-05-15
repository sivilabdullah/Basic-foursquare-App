//
//  ShowDetailViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 20.05.2023.
//

import UIKit
import MapKit
import Parse

class ShowDetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailPlaceNameLB: UILabel!
    
    @IBOutlet weak var detailDescriptionLB: UILabel!
    @IBOutlet weak var detailPlaceTypeLB: UILabel!
    var chosenPlaceId = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()

     getData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromShowDetailToShowMap"{
            let destination = segue.destination as? ShowMapViewController
            destination?.selectedPlaceId = chosenPlaceId
            destination?.selectedAnnotationType = detailPlaceTypeLB.text!
            destination?.selectedAnnotationTitle = detailPlaceNameLB.text!
        }
    }

    func getData(){
        let query = PFQuery(className: "Places")
         query.whereKey("objectId", equalTo: chosenPlaceId)
         query.findObjectsInBackground { objects, error in
             if error != nil {
                 AlertManager.alert(title: "get data error", message: error?.localizedDescription ?? "undefined error", vc: self)
             }else{
                 if objects != nil {
                     let chosenObject = objects![0]
                     if let placeName =  chosenObject.object(forKey: "name") as? String{
                         self.detailPlaceNameLB.text = placeName
                     }
                     if let placeType = chosenObject.object(forKey: "type") as? String{
                         self.detailPlaceTypeLB.text = placeType
                     }
                     if let placeDescription = chosenObject.object(forKey: "description") as? String {
                         self.detailDescriptionLB.text = placeDescription
                     }
    
                      //get image
                     
                     if let imageData = chosenObject.object(forKey: "image") as? PFFileObject{
                         imageData.getDataInBackground { data, error in
                             if error == nil {
                                 if data != nil {
                                     self.detailImageView.image = UIImage(data: data!)
                                 }
                             }else{
                                 
                             }
                         }
                     }
                     
                 }
             }
         }
    }
    @IBAction func goToMapBtn(_ sender: Any) {
        performSegue(withIdentifier: "fromShowDetailToShowMap", sender: nil)
    }
    
}

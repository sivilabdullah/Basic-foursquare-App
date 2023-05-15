//
//  DetailViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 19.05.2023.
//

import UIKit
import PhotosUI
class AddInfoViewController: UIViewController, PHPickerViewControllerDelegate{

    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeNameTF: UITextField!
    
    @IBOutlet weak var placeTypeTF: UITextField!
    
    @IBOutlet weak var descriptionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(accessGallery))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
    }

    @objc func accessGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker,animated: true)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            let previousImage = placeImageView.image
            itemProvider.loadObject(ofClass: UIImage.self){[weak self] image, error in
                DispatchQueue.main.async {
                    //select image process
                    guard let self = self, let image = image as? UIImage, self.placeImageView.image == previousImage else {return}
                    self.placeImageView.image = image
                }
            }
        }
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        if placeNameTF.text != "" && descriptionTF.text != "" && placeTypeTF.text != ""{
            if let _ = placeImageView.image{
                placeInfos.sharedInstance.placeName = placeNameTF.text!
                placeInfos.sharedInstance.placeType = placeTypeTF.text!
                placeInfos.sharedInstance.description = descriptionTF.text!
                placeInfos.sharedInstance.placeImage = placeImageView.image!
                performSegue(withIdentifier: "toMapVC", sender: nil)
                print("transfer successfully")
            }
        }else{
            AlertManager.alert(title: "error", message: "fields not be blank", vc: self)
        }
    }
}

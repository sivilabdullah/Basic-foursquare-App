//
//  ListViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 19.05.2023.
//

import UIKit
import Parse
class ListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceName = ""
    var selectedPlaceId = ""
    var selectedDescription = ""
    var selectedPlaceType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBtn))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", image: .none, target: self, action: #selector(logOut))
        getdata()
    }
    
    @objc func logOut(){
        PFUser.logOutInBackground { error in
            if error != nil {
                AlertManager.alert(title: "error", message: error?.localizedDescription ?? "undefined error", vc: self)
            }else{
                self.performSegue(withIdentifier: "toLogOut", sender: nil)
            }
        }
    }
    
    @objc func addBtn(){
        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = placeNameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    
    func getdata (){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                AlertManager.alert(title: "database error", message: error?.localizedDescription ?? "undefined error", vc: self)
            }else{
                if objects != nil{
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                    self.listTableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailCell" {
            let destinationVC = segue.destination as! ShowDetailViewController
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailCell", sender: nil)
    }
   
    
}


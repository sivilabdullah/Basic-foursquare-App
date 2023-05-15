//
//  PlaceSingleton.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 20.05.2023.
//

import Foundation
import UIKit
class placeInfos {
    static let sharedInstance = placeInfos()
    
    var placeName = ""
    var placeType = ""
    var description = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}
}

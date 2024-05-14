//
//  DetailViewController.swift
//  TamuSMap
//
//
//  Created by MM on 4/7/2022.
//  Copyright © 2022 MM. All rights reserved.
//
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var tamuMap: MKMapView!
    
    var my_placemark: CLPlacemark!
    
    var AddToShow: String = " "
    var NameOfMember: String = " "
    
    func setNewAddress(Member: String, formap address: String) {
        print("Address: ", address)
        AddToShow = address
        NameOfMember = Member
    }
    
    func configureMap() {
        // Update the user interface for the detail item.
        detailDescriptionLabel.text = NameOfMember + " @ " + AddToShow
        
        CLGeocoder().geocodeAddressString(AddToShow, completionHandler: {(placemarks, error) in
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if (placemarks?.count)! > 0 {
                self.my_placemark = placemarks![0]
                let MKplacemark: MKPlacemark = MKPlacemark(placemark: self.my_placemark)
                let pmCircularRegion: CLCircularRegion = (self.my_placemark.region as! CLCircularRegion)
                var region: MKCoordinateRegion
                region = MKCoordinateRegion(center: pmCircularRegion.center, latitudinalMeters: pmCircularRegion.radius * 20, longitudinalMeters: pmCircularRegion.radius * 20)
                self.tamuMap.setRegion(region, animated: true)
                self.tamuMap.addAnnotation(MKplacemark)
            }
        })
    }
    
    @IBAction func ZoomOut(sender: AnyObject) {
        var region = tamuMap.region
        region.span.latitudeDelta *= 2;
        region.span.longitudeDelta *= 2;
        tamuMap.setRegion(region, animated: true)
    }
    
    @IBAction func Zin(sender: AnyObject) {
        var region = tamuMap.region
        region.span.latitudeDelta /= 2;
        region.span.longitudeDelta /= 2;
        tamuMap.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMap()
    }
}


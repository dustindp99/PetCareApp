//
//  ParkViewController.swift
//  PetCareApp
//
//  Created by Dustin on 11/1/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import UIKit
import MapKit

class ParkViewController: UIViewController {

    
    @IBOutlet weak var addressTextBox: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(_ sender: Any) {
        let geoCoder = CLGeocoder();
        let cityString = addressTextBox.text!
        CLGeocoder().geocodeAddressString(cityString,
            completionHandler:
            {(placemarks, error) in
                if error != nil {
                    
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                }
                
        })    }
    
    
    @IBAction func showParks(_ sender: Any) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "park"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start {  response, _ in
            guard let response = response else {
                return
            }
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            
            for i in 0...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                
                self.map.addAnnotation(ani)
                
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

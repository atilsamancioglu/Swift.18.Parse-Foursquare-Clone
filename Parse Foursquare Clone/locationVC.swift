//
//  locationVC.swift
//  Parse Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 10/02/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class locationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var chosenLatitude = ""
    var chosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(locationVC.pressGesture(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chosenLatitude = ""
        self.chosenLongitude = ""
    }
    
    func pressGesture(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = globalName
            annotation.subtitle = globalType
            
            self.mapView.addAnnotation(annotation)
            
            
            self.chosenLatitude = String(coordinates.latitude)
            self.chosenLongitude = String(coordinates.longitude)
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        manager.stopUpdatingLocation()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let object = PFObject(className: "Places")
        object["name"] = globalName
        object["type"] = globalType
        object["atmosphere"] = globalAtmosphere
        object["latitude"] = self.chosenLatitude
        object["longitude"] = self.chosenLongitude
        
        if let imageData = UIImageJPEGRepresentation(globalImage, 0.5) {
           object["image"] = PFFile(name: "image.jpg", data: imageData)
        }
        
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil)
                
                self.performSegue(withIdentifier: "fromLocationtoPlacesVC", sender: nil)
                
            }
        }
        
        
        
        
    }

}

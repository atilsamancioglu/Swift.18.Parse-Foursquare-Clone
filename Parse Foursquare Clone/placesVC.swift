//
//  placesVC.swift
//  Parse Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 09/02/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Parse

class placesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    
    var tappedPlace = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromServer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(placesVC.getDataFromServer), name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPlacestoDetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.chosenPlace = self.tappedPlace
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tappedPlace = placeNameArray[indexPath.row]
        self.performSegue(withIdentifier: "fromPlacestoDetailsVC", sender: nil)
    }
    
    
    
    func getDataFromServer() {
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                self.placeNameArray.removeAll(keepingCapacity: false)
                
                for object in objects! {
                    self.placeNameArray.append(object.object(forKey: "name") as! String)
                }
                
                self.tableView.reloadData()
                
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "fromPlacestoAttributesVC", sender: nil)
        
    }
    

    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                UserDefaults.standard.removeObject(forKey: "userloggedin")
                UserDefaults.standard.synchronize()
                
                let signUpController = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                
                delegate.window?.rootViewController = signUpController
                
                delegate.rememberLogin()
                
            }
        }
        
    }



}

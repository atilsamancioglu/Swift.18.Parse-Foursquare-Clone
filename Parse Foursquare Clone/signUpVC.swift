//
//  ViewController.swift
//  Parse Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 09/02/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let object = PFObject(className: "SouthparkCharacters")
        object["name"] = "Kenny"
        object["age"] = 9
        object["haircolor"] = "Blond"
        object.saveInBackground { (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("object has been created!")
            }
        }
        
        
        let query = PFQuery(className: "SouthparkCharacters")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(objects)
            }
        }
        
        
        
    }

  


}


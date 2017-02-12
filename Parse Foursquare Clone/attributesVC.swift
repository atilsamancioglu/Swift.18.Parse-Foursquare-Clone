//
//  attributesVC.swift
//  Parse Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 10/02/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit

    var globalName = ""
    var globalType = ""
    var globalAtmosphere = ""
    var globalImage = UIImage()

class attributesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(attributesVC.selectImage))
        placeImage.addGestureRecognizer(gestureRecognizer)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        globalName = ""
        globalType = ""
        globalAtmosphere = ""
        globalImage = UIImage()
    }
    
    func selectImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        placeImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
   
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
        if nameText.text != "" {
            if typeText.text != "" {
                if atmosphereText.text != "" {
                    
                    if let pickedImage = placeImage.image {
                        
                        globalName = nameText.text!
                        globalType = typeText.text!
                        globalAtmosphere = atmosphereText.text!
                        globalImage = pickedImage
                        
                    }
                }
            }
        }
        
        
        self.performSegue(withIdentifier: "fromAttributestoLocationVC", sender: nil)
        
        nameText.text = ""
        typeText.text = ""
        atmosphereText.text = ""
        self.placeImage.image = UIImage(named: "tapme.png")
        
    }


}

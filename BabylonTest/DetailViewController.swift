//
//  DetailViewController.swift
//  BabylonTest
//
//  Created by Abid Ghani on 09/02/2016.
//  Copyright © 2016 BOSS Computing. All rights reserved.
//

import UIKit
import Haneke

class DetailViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    var celebrity: Celebrity?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.photo.layer.cornerRadius = self.photo.frame.size.width/2
        self.photo?.layer.masksToBounds = true
     
        if let firstName = self.celebrity?.firstName {
            self.firstNameLabel.text = firstName
        }
        
        if let lastName = self.celebrity?.lastName {
            self.lastNameLabel.text = lastName
        }
        
        if let address = self.celebrity?.address {
            self.addressLabel.text = address
        }
        
        if let phone = self.celebrity?.phoneNumber {
            self.phoneLabel.text = phone
        }
        
        if let email = self.celebrity?.email {
            self.emailLabel.text = email
            if email != "no email" {
                let urlString = "http://api.adorable.io/avatars/200/" + email
                let url = NSURL(string: urlString)
                self.photo.hnk_setImageFromURL(url!)
            } else {
                let image : UIImage = UIImage(named:"camera")!
                self.photo.image = image
            }
        }
        
        if let createdAt = self.celebrity?.createdAt {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let createdDate = dateFormatter.dateFromString(createdAt)
            dateFormatter.dateFormat = "dd MMMM 'at' HH:mm a"
            self.createdDateLabel.text = dateFormatter.stringFromDate(createdDate!)
        }
        
    }
    

   

}

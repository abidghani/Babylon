//
//  Celebrity.swift
//  BabylonTest
//
//  Created by Abid Ghani on 10/02/2016.
//  Copyright © 2016 BOSS Computing. All rights reserved.
//

import UIKit

class Celebrity : NSObject, NSCoding {
    
    struct Keys {
        static let firstName = "FirstName"
        static let lastName = "LastName"
        static let address = "Address"
        static let phoneNumber = "PhoneNumber"
        static let email = "Email"
        static let createdAt = "CreatedAt"
    }
    
    var firstName = ""
    var lastName = ""
    var address = ""
    var phoneNumber = ""
    var email = ""
    var createdAt = ""
    
    init(dictionary: [String : String]) {
        firstName = dictionary[Keys.firstName]!
        lastName = dictionary[Keys.lastName]!
        address = dictionary[Keys.address]!
        phoneNumber = dictionary[Keys.phoneNumber]!
        
        if let emailX = dictionary[Keys.email]{
            if emailX == ""{
                email = "no email"
            } else {
                email = emailX
            }
        } else {
            email = "no email"
        }
        
        createdAt = dictionary[Keys.createdAt]!
    }
    
    func encodeWithCoder(archiver: NSCoder) {
        archiver.encodeObject(firstName, forKey: Keys.firstName)
        archiver.encodeObject(lastName, forKey: Keys.lastName)
        archiver.encodeObject(address, forKey: Keys.address)
        archiver.encodeObject(phoneNumber, forKey: Keys.phoneNumber)
        archiver.encodeObject(email, forKey: Keys.email)
        archiver.encodeObject(createdAt, forKey: Keys.createdAt)
    }
    
    required init(coder unarchiver: NSCoder) {
        super.init()
        firstName = unarchiver.decodeObjectForKey(Keys.firstName) as! String
        lastName = unarchiver.decodeObjectForKey(Keys.lastName) as! String
        address = unarchiver.decodeObjectForKey(Keys.address) as! String
        phoneNumber = unarchiver.decodeObjectForKey(Keys.phoneNumber) as! String
        email = unarchiver.decodeObjectForKey(Keys.email) as! String
        createdAt = unarchiver.decodeObjectForKey(Keys.createdAt) as! String
    }
}
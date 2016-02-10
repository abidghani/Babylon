//
//  DataEngine.swift
//  BabylonTest
//
//  Created by Abid Ghani on 10/02/2016.
//  Copyright © 2016 BOSS Computing. All rights reserved.
//

import UIKit

protocol DownloadMonitor {
    func downloadComplete()
    func downloadFail(error:NSError)
}

class DataEngine: NSObject, NSURLSessionDelegate {
    
    var delegate: DownloadMonitor?

    
    private var downloadTask: NSURLSessionDownloadTask?
    
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        return url.URLByAppendingPathComponent("celebritiesArray").path!
    }
    
     func getData(){

        // Go and fetch the celebrity data.
        let downloadRequest = NSMutableURLRequest(URL: NSURL(string: "http://fast-gorge.herokuapp.com/contacts")!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        downloadTask = session.downloadTaskWithRequest(downloadRequest)
        downloadTask!.resume()
    
    }
    
    func URLSession(session: NSURLSession!, downloadTask: NSURLSessionDownloadTask!, didFinishDownloadingToURL location: NSURL!) {
        
        var celebrityArray:NSArray = NSArray()
        var celebrityArray2:[Celebrity] = []
        let celebrityData = NSData(contentsOfURL: location)
        
        do {
             celebrityArray = try NSJSONSerialization.JSONObjectWithData(celebrityData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        }
        catch let error as NSError{
            print("Something went wrong! \(error.localizedDescription)")
        }


        // write the celebrities to disk
        for celebrity in celebrityArray {
            
            // create a dictionary
            var celebrityDictionary: Dictionary<String, String> = [:]
            
            if let firstName = celebrity["first_name"]!{
                celebrityDictionary["FirstName"] = (firstName as! String)
            }
            
            if let lastName = celebrity["surname"]!{
                celebrityDictionary["LastName"] = (lastName as! String)
            }
            
            if let address = celebrity["address"]!{
                celebrityDictionary["Address"] = (address as! String)
            }
            
            if let phoneNumber = celebrity["phoneNumber"]!{
                celebrityDictionary["PhoneNumber"] = (phoneNumber as! String)
            } else {
                celebrityDictionary["PhoneNumber"] = "n/a"
            }
            
            if let email = celebrity["email"]!{
                celebrityDictionary["Email"] = (email as? String)
                // create the avator URL.
                //let avatarString = "http://api.adorable.io/avatars/200/" + (email as? String)!
                
                
                
            } else {
                celebrityDictionary["Email"] = "n/a"
            }
            
            if let createdAt = celebrity["createdAt"]!{
                celebrityDictionary["CreatedAt"] = (createdAt as! String)
            }
            
            let newCelebrity = Celebrity(dictionary: celebrityDictionary)
            celebrityArray2.append(newCelebrity)
            
        }
        
        // persist to disk.
        NSKeyedArchiver.archiveRootObject(celebrityArray2, toFile: filePath)
        
        // inform the delegate.
        delegate!.downloadComplete()
        
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
        if (error != nil) {
            delegate?.downloadFail(error!)
        }
    }

    

}

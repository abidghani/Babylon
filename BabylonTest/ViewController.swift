//
//  ViewController.swift
//  BabylonTest
//
//  Created by Abid Ghani on 09/02/2016.
//  Copyright © 2016 BOSS Computing. All rights reserved.
//

import UIKit
import Haneke

class ViewController: UIViewController, DownloadMonitor,UITableViewDelegate, UITableViewDataSource  {
    
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        return url.URLByAppendingPathComponent("celebritiesArray").path!
        
    }
    
    var celebrities:NSArray = []

    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pleaseWaitLabel: UILabel!
    @IBOutlet weak var downLoadFailedText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.activityView.hidden = true
        // Check if we have the data already.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let getCelebrityPath = paths.stringByAppendingPathComponent("celebritiesArray")
        let checkValidation = NSFileManager.defaultManager()
        
        if (checkValidation.fileExistsAtPath(getCelebrityPath))
        {
            
            // we have the data, load the tableview.
            self.celebrities = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! NSArray
        
        }
        else
        {
            // we have no data, lets put up a waiting panel, while we fetch in the background.
            self.activityView.hidden = false
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
            self.pleaseWaitLabel.hidden = false
            self.downLoadFailedText.hidden = true
            
            let dataHelper = DataEngine()
            dataHelper.delegate = self
            dataHelper.getData()
        }
    }
    
    func downloadComplete() {
        
        self.celebrities = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! NSArray
        
        for celebrity in celebrities {
            
            let celebrity2 = celebrity as! Celebrity
            let firstName = celebrity2.firstName
            self.activityView.hidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    
    }
    
    func downloadFail(error:NSError){
        
        print("there was an error whilst attempting to download: \(error.localizedDescription)")
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        self.pleaseWaitLabel.hidden = true
        self.downLoadFailedText.hidden = false

    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.celebrities.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CelebrityCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CelebrityCell
        let celebrity2 = self.celebrities[indexPath.row] as! Celebrity
        let firstName = celebrity2.firstName
        let lastName = celebrity2.lastName
        
        // get photo
        if let email = celebrity2.email as? String {
            if email != "no email" {
                let urlString = "http://api.adorable.io/avatars/200/" + email
                let url = NSURL(string: urlString)
                cell.celebrityPhoto.hnk_setImageFromURL(url!)
            } else {
                let image : UIImage = UIImage(named:"logo")!
                cell.celebrityPhoto.image = image
            }
        } else {
            let image : UIImage = UIImage(named:"logo")!
            cell.celebrityPhoto.image = image
        }
        
        cell.celebrityNameLabel.text = firstName + " " + lastName
        return cell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let detailView = segue.destinationViewController as? DetailViewController {
            
            let selectedCelebrity = self.tableView.indexPathForCell(sender as! CelebrityCell)
            let celebrity = self.celebrities[(selectedCelebrity?.row)!] as! Celebrity
            detailView.celebrity = celebrity
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


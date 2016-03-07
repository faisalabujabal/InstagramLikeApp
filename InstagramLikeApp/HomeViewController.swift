//
//  HomeViewController.swift
//  InstagramLikeApp
//
//  Created by Faisal Abu Jabal on 3/7/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var homeTableView: UITableView!
    
    // let homePageQuery
    
    var imagesDictionary: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let imageArray = media {
                
                self.imagesDictionary = imageArray
                
                self.homeTableView.reloadData()
                
                //                print("Number of images retreived: \(imageArray.count)")
                //
                //                for object in imageArray {
                //
                //                    print(object)
                //
                //                    let caption = object["caption"] as! String
                //                    print(caption)
                //                }
            }
        }
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            self.performSegueWithIdentifier("LogoutSegue", sender: nil)
        }
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(imagesDictionary != nil){
            return (imagesDictionary!.count)
        } else {
            return 0
        }
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCellWithIdentifier("ImagesCell", forIndexPath: indexPath) as! ImagesView
        
        cell.imageImageView.file = imagesDictionary![indexPath.row]["media"] as? PFFile
        cell.imageImageView.loadInBackground()
        
        cell.captionLabel.text = imagesDictionary![indexPath.row]["caption"] as? String
        
        return cell
    }

}

//
//  PostImageViewController.swift
//  InstagramLikeApp
//
//  Created by Faisal Abu Jabal on 3/7/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class PostImageViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var edittedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = edittedImage
        
    }
    
    @IBAction func onPost(sender: AnyObject) {
        Post.postUserImage(edittedImage, withCaption: captionTextField.text) { (success: Bool, error: NSError?) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

//
//  PreviewViewController.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/6/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButtonPressed(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            print("Received an image")
        }
    }

}


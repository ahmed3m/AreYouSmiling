//
//  PreviewViewController.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/6/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class PreviewViewController: UIViewController {

    var photoTakingHelper: PhotoTakingHelper?
    var photos: [UIImage] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButtonPressed(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            let imageData = UIImageJPEGRepresentation(image!, 0.8)
            let headers = [   // The headers are configurations done when calling an api
                "Content-Type": "application/json",
                "Ocp-Apim-Subscription-Key": "ed0a6aa43a044651b5efe67de5ac4ae8"
            ]
            let apiToContact = "https://api.projectoxford.ai/emotion/v1.0/recognize"  // That's the request URL to communicate with the api
            
            // The parameters are things we'd like to pass to the api. It's always an array of dictionaries
            let paramters: [String: AnyObject] = ["url": imageData!] // there's an issue with imageData. Doesn't seem to be supported
            // Used "encoding: .JSON" to specify that the parameters are in JSON format
            Alamofire.request(.POST, apiToContact, headers: headers, parameters: paramters).validate().responseJSON() { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json)
                    }
                case .Failure(let error):
                    print(error)
                }
            }
            self.photos.append(image!)
            self.tableView.reloadData()
        }
    }

}

extension PreviewViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("previewCell", forIndexPath: indexPath) as! PreviewTableViewCell
        cell.previewImageView.image = photos[indexPath.row]
        cell.emojiLabel.text = Emoji.contempt.rawValue
        return cell
    }
}
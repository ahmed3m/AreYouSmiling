//
//  PreviewViewController.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/6/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import UIKit
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
        /*
        let apiToContact = "https://api.projectoxford.ai/emotion/v1.0/recognize"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
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
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButtonPressed(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            // take image and pass it to the api, and recieve info
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
        cell.emojiLabel.text = "🙂"
        return cell
    }
}
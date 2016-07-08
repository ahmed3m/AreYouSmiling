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
    var emotions: Emotions?
    var emoji: [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButtonPressed(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            let parameters = [
                "entities" : "true",
                "faceRectangles": "true",
                ]
            let imageData = UIImageJPEGRepresentation(image!, 0.3)

            // CREATE AND SEND REQUEST
            let urlRequest = self.urlRequestWithComponents("https://api.projectoxford.ai/emotion/v1.0/recognize", parameters: parameters, imageData: imageData!)
            Alamofire.upload(urlRequest.0, data: urlRequest.1)
                .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                    print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
                }.responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in
                    if let error = response.result.error {
                        print(error)
                    } else {
                        let emotion = JSON(response.result.value ?? [])
                        self.emotions = Emotions(json: emotion)
                        let bestEmotion = self.emotions?.getBestEmotion()
                        self.emoji.insert((self.emotions?.getRightEmoji(bestEmotion!))!, atIndex: 0)
                        self.photos.insert(image!, atIndex: 0)
                        self.tableView.reloadData()
                    }
                })
        }
    }
    
    func urlRequestWithComponents(urlString: String, parameters: Dictionary<String, String>, imageData: NSData) -> (URLRequestConvertible, NSData) {
        // create url request to send
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        
        // please use your own key to upload images
        mutableURLRequest.setValue("ed0a6aa43a044651b5efe67de5ac4ae8", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        mutableURLRequest.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        // create upload data to send
        let uploadData = NSMutableData()
        // add image
        uploadData.appendData(imageData)
        // add parameters
        for (key, value) in parameters {
            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        // return URLRequestConvertible and NSData
        return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }

}



extension PreviewViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("previewCell", forIndexPath: indexPath) as! PreviewTableViewCell
        cell.previewImageView.image = photos[indexPath.row]
        cell.emojiLabel.text = emoji[indexPath.row].rawValue
        return cell
    }
}
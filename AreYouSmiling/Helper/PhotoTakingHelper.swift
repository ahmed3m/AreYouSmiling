//
//  PhotoTakingHelper.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/6/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper: NSObject {
    
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        super.init()
        showAlertController()
    }
    
    func showAlertController() {
        let alertController = UIAlertController(title: nil, message: "Where would you like to get the picture from?", preferredStyle: .ActionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.showImagePickerController(.Camera)
        }
        alertController.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (action) in
            self.showImagePickerController(.PhotoLibrary)
        }
        alertController.addAction(photoLibraryAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showImagePickerController(soureType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.sourceType = soureType
        viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /*
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL // local url
        let imagePath =  imageURL.path! // short path in asset
        let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(imagePath) // full path
        //this block of code adds data to the above path
        let path = localPath.relativePath! // didn't need to use 'file:///'
        let imageName = info[UIImagePickerControllerOriginalImage] as! UIImage // the image
        let data = UIImagePNGRepresentation(imageName) // NSData of image in PNG
        data?.writeToFile(imagePath, atomically: true)
        
        callback(imageName, data!)
        picker.dismissViewControllerAnimated(false, completion: nil)
    }
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        callback(image)
        picker.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
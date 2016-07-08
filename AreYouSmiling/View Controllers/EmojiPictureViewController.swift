//
//  EmojiPictureViewController.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/8/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import UIKit

class EmojiPictureViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emojiLabel: UILabel!
    
    var localImage: UIImage?
    var localEmoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        imageView.image = localImage
        emojiLabel.text = localEmoji?.rawValue
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

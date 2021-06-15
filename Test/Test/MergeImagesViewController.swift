//
//  MergeImagesViewController.swift
//  Test
//
//  Created by developer on 15/06/21.
//

import UIKit

class MergeImagesViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var mergedImageView: UIImageView!

    var image1 = UIImage()
    var image2 = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstImageView.image = self.image1
        self.secondImageView.image = self.image2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mergeImages()
    }
    
    func mergeImages() {
        let size = CGSize(width: image1.size.width, height: image1.size.height + image2.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        image1.draw(in: CGRect(x: 0, y: 0, width: size.width, height: image1.size.height))
        image2.draw(in: CGRect(x: 0, y: image1.size.height, width: size.width, height: image2.size.height))

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.mergedImageView.image = newImage
    }
}

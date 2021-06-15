//
//  HomeViewController.swift
//  Test
//
//  Created by developer on 15/06/21.
//

import UIKit
import PhotosUI

class HomeViewController: UIViewController {

    var imagePicker = UIImagePickerController()
    
    var image1: UIImage?
    var image2: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.image1 = nil
        self.image2 = nil
    }

    @IBAction func takeImageClicked(_ sender: UIButton) {
        self.requestAuthorization()
    }
    
    func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async {
                switch status {
                case .notDetermined, .restricted, .denied:
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                case .authorized:
                    self.openLibrary()
                default:
                    break
                }
            }
        }
    }
    
    func openLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
       func imagePickerController(_ picker: UIImagePickerController,
                                  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        picker.dismiss(animated: true, completion: {
            if self.image1 == nil {
                self.image1 = image
            } else if self.image2 == nil {
                self.image2 = image
                self.moveToMergeView()
            }
        })
    }
    
    func moveToMergeView() {
        let mergeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MergeImagesViewController") as! MergeImagesViewController
        mergeViewController.image1 = image1!
        mergeViewController.image2 = image2!
        self.navigationController?.pushViewController(mergeViewController, animated: true)
    }
    
}

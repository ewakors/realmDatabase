//
//  AddNewPhotoViewController.swift
//  realmDatabase
//
//  Created by goapps on 04.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

class AddNewPhotoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newPhotoName: UILabel!
    @IBOutlet weak var nameLabelTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
     var picker:UIImagePickerController?=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker?.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPhotoButtonClick(_ sender: Any) {
        openGallary()
    }

    // Open Gallery button click
    @IBAction func OpenGallery(sender: AnyObject) {
        openGallary()
    }
    
    // Take Photo button click
    @IBAction func TakePhoto(sender: AnyObject) {
        openCamera()
    }
    
    
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
}

extension AddNewPhotoViewController {
    
}

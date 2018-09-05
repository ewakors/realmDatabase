//
//  AddNewPhotoViewController.swift
//  realmDatabase
//
//  Created by goapps on 04.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewPhotoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newPhotoName: UILabel!
    @IBOutlet weak var nameLabelTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    var picker =  UIImagePickerController()
    var realm: Realm = try! Realm()
    var items: Results<Photo>?
    var notificationToken: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate=self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonDidClick))
    }
    
    func openGallary()
    {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func saveButtonDidClick() {
        let photo = Photo()
        photo.imageName = nameLabelTF.text ?? ""
        if let image = imageView.image, let data = UIImageJPEGRepresentation(image,0.5), let imgPNG = UIImage(data: NSData(data: data ) as Data), let dataPNGImg = UIImagePNGRepresentation(imgPNG) {
                photo.image = NSData(data: dataPNGImg) as Data
        }
        
        try! self.realm.write {
            self.realm.add(photo)
            
        }
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButtonClick(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Aparat", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openCamera()
        })
        let libraryAction = UIAlertAction(title: "Galeria", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallary()
        })
        
        let cancelAction = UIAlertAction(title: "Anuluj", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}

extension AddNewPhotoViewController {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
    }
}

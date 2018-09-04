//
//  PhotoTableViewCell.swift
//  realmDatabase
//
//  Created by goapps on 04.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoName: UILabel!
    
    let info: String = "photoModel.uuid"
    override func awakeFromNib() {
        super.awakeFromNib()
        photoName.text = info
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure (photoModel: Results<Photo>) {
        
//            photoName.text = photoModel.first?.imageName
        
        
//        photo.image = UIImage(data: photoModel.image)
    }
    
}

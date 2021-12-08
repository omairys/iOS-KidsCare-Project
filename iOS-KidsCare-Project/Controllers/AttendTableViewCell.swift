//
//  AttendTableViewCell.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-05.
//

import UIKit
import FirebaseStorage

class AttendTableViewCell: UITableViewCell{
    @IBOutlet weak var nameAttend: UILabel!
    @IBOutlet weak var imageToddler: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAttendToddlerCell(obj:Toddler)
    {
        nameAttend.text = String(obj.mName!) + " " + String(obj.mLastname!)
        
        let downloadRef = Storage.storage().reference(withPath: obj.mImageUrl!)
        downloadRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.imageToddler.image = image
            }
          }
    }
}

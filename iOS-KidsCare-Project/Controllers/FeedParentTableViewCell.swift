//
//  TableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-06.
//

import UIKit
import FirebaseStorage

class FeedParentTableViewCell: UITableViewCell{
    @IBOutlet weak var imageviewFeed: UIImageView!
    @IBOutlet weak var tituloFeed: UILabel!
    @IBOutlet weak var fechaFeed: UILabel!
    @IBOutlet weak var descripcionFeed: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAttendFeedCell(obj:Feed)
    {
        tituloFeed.text = String(obj.mTitle!)
        fechaFeed.text = String(obj.mDate!)
        descripcionFeed.text = String(obj.mDescription!)
        let downloadRef = Storage.storage().reference(withPath: obj.mUserImage!)
        downloadRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.imageviewFeed.image = image
            }
          }
    }
}

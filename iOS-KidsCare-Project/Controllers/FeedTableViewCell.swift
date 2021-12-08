//
//  FeedTableViewCell.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-07.
//

import UIKit
import FirebaseStorage

class FeedTableViewCell: UITableViewCell{
    @IBOutlet weak var imageviewParentFeed: UIImageView!
    @IBOutlet weak var tituloParentFeed: UILabel!
    @IBOutlet weak var fechaParentFeed: UILabel!
    @IBOutlet weak var descripcionParentFeed: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAttendFeedCell(obj:Feed)
    {
        tituloParentFeed.text = String(obj.mTitle!)
        fechaParentFeed.text = String(obj.mDate!)
        descripcionParentFeed.text = String(obj.mDescription!)
        let downloadRef = Storage.storage().reference(withPath: obj.mUserImage!)
        downloadRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.imageviewParentFeed.image = image
            }
          }
    }
}

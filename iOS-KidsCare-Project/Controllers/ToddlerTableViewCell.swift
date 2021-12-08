//
//  ToddlerTableViewCell.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-04.
//

import UIKit

class ToddlerTableViewCell: UITableViewCell{
    @IBOutlet weak var nameToddler: UILabel!
    @IBOutlet weak var classroomToddler: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setToddlerCell(obj:Toddler)
    {
        nameToddler.text = String(obj.mName!) + " " + String(obj.mLastname!)
        classroomToddler.text = obj.mClassRoom
    }
    
    
}

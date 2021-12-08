//
//  AcceptKidTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-06.
//

import UIKit
import FirebaseStorage

class AcceptKidTableViewController: UITableViewController {
    @IBOutlet weak var imageKidAcept: UIImageView!
    @IBOutlet weak var nameKidAcept: UILabel!
    @IBOutlet weak var classroomKidAcept: UILabel!
    @IBOutlet weak var lastnameKidAcept: UILabel!
    @IBOutlet weak var bdayKidAcept: UILabel!
    @IBOutlet weak var genderKidAcept: UILabel!
    @IBOutlet weak var alergiesKidAcept: UILabel!
    @IBOutlet weak var ecpKidAcept: UILabel!
    @IBOutlet weak var ecpnKidAcept: UILabel!
    
    var feed:Feed?
    var toddler: Toddler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let idKid = feed?.mkid
        Manager.toddler.getDataOfToddlerByID(id: idKid!, completion: { results in
            self.toddler = results
            self.setUIValues()
        })
        
    }
    
    //gestiona las alertas
    func displayAlert(title: String, message:String){
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true, completion: nil)
    }
    
    func setUIValues(){
        let downloadRef = Storage.storage().reference(withPath: (toddler?.mImageUrl)!)
        downloadRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.imageKidAcept.image = image
            }
          }
        
        nameKidAcept.text = toddler?.mName
        classroomKidAcept.text = toddler?.mClassRoom
        lastnameKidAcept.text = toddler?.mLastname
        bdayKidAcept.text = toddler?.mBirthday
        genderKidAcept.text = toddler?.mGender
        alergiesKidAcept.text = toddler?.mAlergies
        ecpKidAcept.text = toddler?.mEmergencyPhone
        ecpnKidAcept.text = toddler?.mEmergencyName
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = toddler?.mUid
        //update enrrollment
        Manager.toddler.setEnrollByID(id: id!, completion: {
            
        })
        
        updateFeed()
    }
    
    func updateFeed(){
        let idFeed = feed?.mIdf
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyyMMddhhmmss"
        let dateString2 = dateFormatter2.string(from: Date())
        
        
        //hiddenFeed
        Manager.feed.setHiddenTrue(id: idFeed!, completion: {
            print("the feed was updated")
        })
        
        //create new feed
        Manager.feed.createNewFeed(
            idf: DefaultData.user.mUid!+dateString2+"1",
            title: DefaultData.user.mName! + " have accepted " + (toddler?.mName)!,
            description: "You have accepted " + (toddler?.mName)! + " registration in your classroom",
            visibility: DefaultData.user.mClassroom!,
            associatedImage: "",
            userImage: DefaultData.user.mImageUrl!,
            requiredAction: "NO",
            author: DefaultData.user.mUid!,
            date: dateString,
            kid: (toddler?.mUid)!,
            aid: "",
            completion: {check in if check {
                print("information was added to the feed")
                }
                else {
                    self.displayAlert(title: "No information could be added to the feed", message: "unknow error")
                }
            })
            
        //create new feed for parent
        Manager.feed.createNewFeed(
            idf: DefaultData.user.mUid!+dateString2+"2",
            title: "Acceptance of Enrollment",
            description: "Your toddler " + (toddler?.mName)! + " has been accepted in the classroom "+DefaultData.user.mClassroom!,
            visibility: (toddler?.mParentId)!,
            associatedImage: "",
            userImage: (toddler?.mImageUrl)!,
            requiredAction: "NO",
            author: DefaultData.user.mUid!,
            date: dateString,
            kid: (toddler?.mUid)!,
            aid: "",
            completion: {check in if check {
                print("information was added to the feed")
                }
                else {
                    self.displayAlert(title: "No information could be added to the feed", message: "unknow error")
                }
            })
        navigationController?.popViewController(animated: true)
        
    }
}

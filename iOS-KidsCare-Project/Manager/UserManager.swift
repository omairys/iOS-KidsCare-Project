//
//  UserManager.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-29.
//

import Foundation
import UIKit
import FirebaseDatabase

struct UserManager {
    
    let URL = BASE_URL?.child("Users")
    let URL_TODDLERS = BASE_URL?.child("Toddler")
    let URL_ACTIVITY = BASE_URL?.child("Activities")
    
    func getDataOfUserByID(id: String, completion: @escaping (User) -> Void) {
        //URL?.child(id).child("Info").observeSingleEvent(of: .value) { (snapShot) in
        URL?.child(id).observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let user = User.transfermUser(dictionary: dictionary)
                completion(user)
            }
        }
    }
    
    func createNewAccount(uid: String, name: String, lastname: String, address: String, phone: String, email: String, imageUrl: String, userType: String, classroom: String, completion: @escaping (Bool) -> Void) {
        //URL?.child(uid).child("Info").observeSingleEvent(of: .value) { (snapshot) in
        URL?.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            //if !snapshot.exists() {
                URL?.updateChildValues(
                    [uid: ["name": name,
                          "lastname" : lastname,
                          "address" : address,
                          "phone" : phone,
                          "email" : email,
                          "uid" : uid,
                          "imageUrl" : imageUrl,
                          "userType" : userType,
                          "classroom" : classroom]]
                )
                completion(true)
            //} else { completion(false) }
        }
    }
    
    func getToddlers(completion: @escaping ([Toddler]) -> Void) {
        URL_TODDLERS?.queryOrdered(byChild: "parent_kid_id").queryEqual(toValue: DefaultData.user.mUid).observeSingleEvent(of: .value) { (snapShot) in
            print("There are \(snapShot.childrenCount) children found")
            var myToddlers: [Toddler] = []
            for data in snapShot.children.allObjects as! [DataSnapshot] {
               if let dictionary = data.value as? NSDictionary {
                   let toddler = Toddler.transfermToddler(dictionary: dictionary)
                   myToddlers.append(toddler)
               }
            }
            completion(myToddlers)
        }
    }
    
    func getActivityById(aid: String, completion: @escaping (Activity) -> Void) {
        URL_ACTIVITY?.child(aid).observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let activity = Activity.transfermActivity(dictionary: dictionary)
                completion(activity)
            }
        }
    }
    
    func getToddlersAttendance(completion: @escaping ([Toddler]) -> Void) {
        URL_TODDLERS?.queryOrdered(byChild: "classroom_kid").queryEqual(toValue: DefaultData.user.mClassroom!).observeSingleEvent(of: .value) { (snapShot) in
            print("There are \(snapShot.childrenCount) children found")
            var myToddlers: [Toddler] = []
            for data in snapShot.children.allObjects as! [DataSnapshot] {
               if let dictionary = data.value as? NSDictionary {
                   if (dictionary["enrrolled"] as? Bool)! {
                       let toddler = Toddler.transfermToddler(dictionary: dictionary)
                       myToddlers.append(toddler)
                   }
               }
            }
            completion(myToddlers)
        }
    }
}

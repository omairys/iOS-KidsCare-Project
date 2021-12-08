//
//  ToddlerManager.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-04.
//
import Foundation
import UIKit

struct ToddlerManager {
    
    let URL_TODDLER = BASE_URL?.child("Toddler")
    
    func getDataOfToddlerByID(id: String, completion: @escaping (Toddler) -> Void) {
        //URL?.child(id).child("Info").observeSingleEvent(of: .value) { (snapShot) in
        URL_TODDLER?.child(id).observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let toddler = Toddler.transfermToddler(dictionary: dictionary)
                completion(toddler)
            }
        }
    }
    
    func setEnrollByID(id: String, completion: @escaping () -> Void) {
        //URL?.child(id).child("Info").observeSingleEvent(of: .value) { (snapShot) in
        URL_TODDLER?.child(id).updateChildValues(["enrrolled": true])
    }
    
    func createNewToddler( kid: String, name_kid: String, lastname_kid: String, classRoom_kid: String, emerPhone: String, emerName: String, imageUrl_kid: String, alergies: String, birthday_kid: String, gender_kid: String, parent_kid_id: String, enrrolled: Bool, completion: @escaping (Bool) -> Void) {
        //URL?.child(uid).child("Info").observeSingleEvent(of: .value) { (snapshot) in
        URL_TODDLER?.child(kid).observeSingleEvent(of: .value) { (snapshot) in
            //if !snapshot.exists() {
                URL_TODDLER?.updateChildValues(
                    [kid: ["kid": kid,
                           "name_kid" : name_kid,
                           "lastname_kid" : lastname_kid,
                           "classroom_kid" : classRoom_kid,
                           "emerphone" : emerPhone,
                           "emername" : emerName,
                           "imageurl_kid" : imageUrl_kid,
                           "alergies" : alergies,
                           "birthday_kid" : birthday_kid,
                           "gender_kid" : gender_kid,
                           "parent_kid_id" : parent_kid_id,
                           "enrrolled" : enrrolled]]
                )
                completion(true)
            //} else { completion(false) }
        }
    }
    
}

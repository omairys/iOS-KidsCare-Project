//
//  ActivityManager.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-06.
//

import Foundation

struct ActivityManager {
    let URL_ACTIVITY = BASE_URL?.child("Activities")
    
    func getDataOfActivityByID(id: String, completion: @escaping (Activity) -> Void) {
        URL_ACTIVITY?.child(id).observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let activity = Activity.transfermActivity(dictionary: dictionary)
                completion(activity)
            }
        }
    }
    
    func createNewActivity(aid: String, kid: String, breakfast: String, salad: String, maindish: String, dessert:String, snack:String, milk:String, nap:String, complete:Bool, date:String, completion: @escaping (Bool) -> Void) {
        //URL?.child(uid).child("Info").observeSingleEvent(of: .value) { (snapshot) in
            URL_ACTIVITY?.child(kid).observeSingleEvent(of: .value) { (snapshot) in
            //if !snapshot.exists() {
                URL_ACTIVITY?.updateChildValues(
                    [aid: ["aid": aid,
                           "kid": kid,
                           "breakfast": breakfast,
                           "salad": salad,
                           "maindish": maindish,
                           "dessert": dessert,
                           "snack": snack,
                           "milk": milk,
                           "nap": nap,
                           "complete": complete,
                           "date": date]]
                )
                completion(true)
            //} else { completion(false) }
        }
    }
}

//
//  FeedManager.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-06.
//

import Foundation
import FirebaseDatabase

struct FeedManager {
    let URL_FEED = BASE_URL?.child("Feed")
    
    func getDataOfFeedByID(id: String, completion: @escaping (Feed) -> Void) {
        URL_FEED?.child(id).observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let feed = Feed.transfermFeed(dictionary: dictionary)
                completion(feed)
            }
        }
    }
    
    func setHiddenTrue(id: String, completion: @escaping () -> Void) {
        //URL?.child(id).child("Info").observeSingleEvent(of: .value) { (snapShot) in
        URL_FEED?.child(id).updateChildValues(["hidden": true])
    }
    
    func createNewFeed(
        idf: String,
        title: String,
        description: String,
        visibility: String,
        associatedImage: String,
        userImage: String,
        requiredAction: String,
        author : String,
        date: String,
        kid: String,
        aid: String,
        completion: @escaping (Bool) -> Void) {
        //URL?.child(uid).child("Info").observeSingleEvent(of: .value) { (snapshot) in
        URL_FEED?.child(idf).observeSingleEvent(of: .value) { (snapshot) in
            //if !snapshot.exists() {
            URL_FEED?.updateChildValues(
                    [idf: ["idf": idf,
                         "title": title,
                         "description": description,
                         "visibility": visibility,
                         "associatedImage": associatedImage,
                         "userImage": userImage,
                         "requiredAction": requiredAction,
                         "author" : author,
                         "date": date,
                         "kid": kid,
                         "aid": aid,
                         "hidden": false]]
                )
                completion(true)
            //} else { completion(false) }
        }
    }
    
    func getAllMyFeed(completion: @escaping ([Feed]) -> Void) {
        var classroom = DefaultData.user.mClassroom
        if classroom == "" {
            classroom = UserDefaults.standard.string(forKey: "classroom")
        }
        URL_FEED?.queryOrdered(byChild: "date").observeSingleEvent(of: .value) { (snapShot) in
            print("There are \(snapShot.childrenCount) children found")
            var myFeeds: [Feed] = []
            for data in snapShot.children.allObjects as! [DataSnapshot] {
               if let dictionary = data.value as? NSDictionary {
                   if !(dictionary["hidden"] as? Bool)! && (dictionary["visibility"] as? String)! == classroom {
                       let feed = Feed.transfermFeed(dictionary: dictionary)
                       myFeeds.append(feed)
                   }
               }
            }
            completion(myFeeds.sorted(by: { $0.mDateOrder! >  $1.mDateOrder!} ))
        }
    }
    
    func getAllMyFeedParent(completion: @escaping ([Feed]) -> Void) {
        var user_id_visible = DefaultData.user.mUid
        if user_id_visible == "" {
            user_id_visible = UserDefaults.standard.string(forKey: "userid")
        }
        URL_FEED?.queryOrdered(byChild: "date").observeSingleEvent(of: .value) { (snapShot) in
            print("There are \(snapShot.childrenCount) children found")
            var myFeeds: [Feed] = []
            for data in snapShot.children.allObjects as! [DataSnapshot] {
               if let dictionary = data.value as? NSDictionary {
                   if (dictionary["visibility"] as? String)! == user_id_visible {
                       let feed = Feed.transfermFeed(dictionary: dictionary)
                       myFeeds.append(feed)
                   }
               }
            }
            print(myFeeds.count)
            completion(myFeeds.sorted(by: { $0.mDateOrder! >  $1.mDateOrder!} ))
        }
    }
}

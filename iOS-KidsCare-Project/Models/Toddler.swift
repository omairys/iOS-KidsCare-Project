//
//  Toddler.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-04.
//

import Foundation
class Toddler {
    var mUid: String?
    var mName: String?
    var mLastname: String?
    var mClassRoom: String?
    var mEmergencyPhone: String?
    var mEmergencyName: String?
    var mImageUrl: String?
    var mAlergies: String?
    var mBirthday:String?
    var mGender:String?
    var mParentId:String?
    var mEnrrolled:Bool?
    
    init(){
        mUid = ""
        mName = ""
        mLastname = ""
        mClassRoom = ""
        mEmergencyPhone = ""
        mEmergencyName = ""
        mImageUrl = ""
        mAlergies = ""
        mBirthday = ""
        mGender = ""
        mParentId = ""
        mEnrrolled = false

    }
    
    func ditinit(id: String, completion: @escaping ()->Void) {
        Manager.toddler.getDataOfToddlerByID(id: id, completion: { [self] (toddler) in
            mUid = toddler.mUid
            mName = toddler.mName
            mLastname = toddler.mLastname
            mClassRoom = toddler.mClassRoom
            mEmergencyPhone = toddler.mEmergencyPhone
            mEmergencyName = toddler.mEmergencyName
            mImageUrl = toddler.mImageUrl
            mAlergies = toddler.mAlergies
            mBirthday = toddler.mBirthday
            mGender = toddler.mGender
            mParentId = toddler.mParentId
            mEnrrolled = toddler.mEnrrolled
            
            completion()
        })
    }

    static func transfermToddler(dictionary: NSDictionary) -> Toddler {
        let tdlr = Toddler()
        tdlr.mUid = (dictionary["kid"] as? String)
        tdlr.mName = dictionary["name_kid"] as? String
        tdlr.mLastname = dictionary["lastname_kid"] as? String
        tdlr.mClassRoom = dictionary["classroom_kid"] as? String
        tdlr.mEmergencyPhone = dictionary["emerphone"] as? String
        tdlr.mEmergencyName = dictionary["emername"] as? String
        tdlr.mImageUrl = dictionary["imageurl_kid"] as? String
        tdlr.mAlergies = dictionary["alergies"] as? String
        tdlr.mBirthday = dictionary["birthday_kid"] as? String
        tdlr.mGender = dictionary["gender_kid"] as? String
        tdlr.mParentId = dictionary["parent_kid_id"] as? String
        tdlr.mEnrrolled = dictionary["enrrolled"] as? Bool
        return tdlr
    }
}

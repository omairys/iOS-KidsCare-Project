//
//  User.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-27.
//

import Foundation

class User {
    var mUid: String?
    var mName: String?
    var mLastname: String?
    var mAddress: String?
    var mPhone: String?
    var mEmail: String?
    var mImageUrl: String?
    var mUserType: String?
    var mClassroom: String?
    
    var sourceArrayData: [[String]]
    
    init(){
        mUid = ""
        mName = ""
        mLastname = ""
        mAddress = ""
        mPhone = ""
        mEmail = ""
        mImageUrl = ""
        mUserType = ""
        mClassroom = ""
        sourceArrayData = [[]]
    }
    
    func ditinit(id: String, completion: @escaping ()->Void) {
        Manager.user.getDataOfUserByID(id: id, completion: { [self] (user) in
            mUid = user.mUid
            mName = user.mName
            mLastname = user.mLastname
            mAddress = user.mAddress
            mPhone = user.mPhone
            mEmail = user.mEmail
            mImageUrl = user.mImageUrl
            mUserType = user.mUserType
            mClassroom = user.mClassroom
            
            completion()
        })
    }

    static func transfermUser(dictionary: NSDictionary) -> User {
        let usr = User()
        usr.mUid = (dictionary["uid"] as? String)
        usr.mName = dictionary["name"] as? String
        usr.mLastname = dictionary["lastname"] as? String
        usr.mAddress = dictionary["address"] as? String
        usr.mPhone = dictionary["phone"] as? String
        usr.mEmail = dictionary["email"] as? String
        usr.mImageUrl = dictionary["imageUrl"] as? String
        usr.mUserType = dictionary["userType"] as? String
        usr.mClassroom = dictionary["classroom"] as? String
        return usr
    }
}


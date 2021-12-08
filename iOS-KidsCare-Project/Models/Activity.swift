//
//  Classroom.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-05.
//

import Foundation

class Activity {
    var mAid:String?
    var mKid:String?
    var mBreakfast:String?
    var mSalad:String?
    var mMaindish:String?
    var mDessert:String?
    var mSnack:String?
    var mMilk:String?
    var mNap:String?
    var mComplete:Bool?
    var mDate:String?
    
    init(){
        mAid = ""
        mKid = ""
        mBreakfast = ""
        mSalad = ""
        mMaindish = ""
        mDessert = ""
        mSnack = ""
        mMilk = ""
        mNap = ""
        mComplete = false
        mDate = ""
    }
    
    func ditinit(id: String, completion: @escaping ()->Void) {
        Manager.activity.getDataOfActivityByID(id: id, completion: { [self] (activity) in
            mAid = activity.mAid
            mKid = activity.mAid
            mBreakfast = activity.mBreakfast
            mSalad = activity.mSalad
            mMaindish = activity.mMaindish
            mDessert = activity.mDessert
            mSnack = activity.mSnack
            mMilk = activity.mMilk
            mNap = activity.mNap
            mComplete = activity.mComplete
            mDate = activity.mDate
            completion()
        })
    }
    
    static func transfermActivity(dictionary: NSDictionary) -> Activity {
        let act = Activity()
        act.mAid = (dictionary["aid"] as? String)
        act.mKid = (dictionary["kid"] as? String)
        act.mBreakfast = (dictionary["breakfast"] as? String)
        act.mSalad = (dictionary["salad"] as? String)
        act.mMaindish = (dictionary["maindish"] as? String)
        act.mDessert = (dictionary["dessert"] as? String)
        act.mSnack = (dictionary["snack"] as? String)
        act.mMilk = (dictionary["milk"] as? String)
        act.mNap = (dictionary["nap"] as? String)
        act.mComplete = (dictionary["complete"] as? Bool)
        act.mDate = (dictionary["date"] as? String)
        
        return act
    }
    
}

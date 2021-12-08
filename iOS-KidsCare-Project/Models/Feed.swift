//
//  Feed.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-06.
//

import Foundation

class Feed {
    var mIdf:String?
    var mTitle:String?
    var mDescription:String?
    var mVisibility:String?
    var mAssociatedImage:String?
    var mUserImage:String?
    var mRequiredAction:String?
    var mAuthor:String?
    var mDate:String?
    var mkid:String?
    var maid:String?
    var mDateOrder:Date?

    
    init(){
        mIdf = ""
        mTitle = ""
        mDescription = ""
        mVisibility = ""
        mAssociatedImage = ""
        mUserImage = ""
        mRequiredAction = ""
        mAuthor = ""
        mDate = ""
        mkid = ""
        maid = ""
        mDateOrder = Date()
    }
    
    func ditinit(id: String, completion: @escaping ()->Void) {
        Manager.feed.getDataOfFeedByID(id: id, completion: { [self] (feed) in
            mIdf = feed.mIdf
            mTitle = feed.mTitle
            mDescription = feed.mDescription
            mVisibility = feed.mVisibility
            mAssociatedImage = feed.mAssociatedImage
            mUserImage = feed.mUserImage
            mRequiredAction = feed.mRequiredAction
            mAuthor = feed.mAuthor
            mDate = feed.mDate
            mkid = feed.mkid
            maid = feed.maid
            mDateOrder = feed.mDateOrder
            completion()
        })
    }
    
    static func transfermFeed(dictionary: NSDictionary) -> Feed {
        let feed = Feed()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"// yyyy-MM-dd"
        
        feed.mIdf = (dictionary["idf"] as? String)
        feed.mTitle = (dictionary["title"] as? String)
        feed.mDescription = (dictionary["description"] as? String)
        feed.mVisibility = (dictionary["visibility"] as? String)
        feed.mAssociatedImage = (dictionary["associatedImage"] as? String)
        feed.mUserImage = (dictionary["userImage"] as? String)
        feed.mRequiredAction = (dictionary["requiredAction"] as? String)
        feed.mAuthor = (dictionary["author"] as? String)
        feed.mDate = (dictionary["date"] as? String)
        feed.mkid = (dictionary["kid"] as? String)
        feed.maid = (dictionary["aid"] as? String)
        feed.mDateOrder = dateFormatter.date(from: (dictionary["date"] as? String)!)
        return feed
    }
    
}

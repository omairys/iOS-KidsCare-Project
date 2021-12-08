//
//  Manager.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-29.
//

import Foundation

struct Manager {
    static let user = UserManager()
    static let toddler = ToddlerManager()
    static let activity = ActivityManager()
    static let feed = FeedManager()
}

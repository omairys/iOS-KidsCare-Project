//
//  Common+Extensions.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-01.
//

import Foundation
public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}

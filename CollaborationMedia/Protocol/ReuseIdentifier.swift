//
//  ReuseIdentifier.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import Foundation

protocol ReuseIdentifier: AnyObject {
    static var identifier: String { get }
}

extension ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: ReuseIdentifier { }

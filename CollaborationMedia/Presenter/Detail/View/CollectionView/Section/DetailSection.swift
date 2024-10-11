//
//  DetailSection.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/11/24.
//

import Foundation

enum DetailSection: CaseIterable {
    case detail  // backdrop Image가 헤더뷰
    case similar

    var header: String {
        return switch self {
        case .similar: "비슷한 콘텐츠"
        default: ""
        }
    }

}

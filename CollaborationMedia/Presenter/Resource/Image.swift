//
//  Image.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit

enum Image {
    case play
    case magnifyingglass
    case sparklesTV
    case house
    case playCircle
    case squareAndArrowDown
    case faceSmiling
    case plus
    
    var rawValue: UIImage? {
        switch self {
        case .play: UIImage(systemName: "play.fill")
        case .magnifyingglass: UIImage(systemName: "magnifyingglass")
        case .sparklesTV: UIImage(systemName: "sparkles.tv")
        case .house: UIImage(systemName: "house.fill")
        case .playCircle: UIImage(systemName: "play.circle")
        case .squareAndArrowDown: UIImage(systemName: "square.and.arrow.down")
        case .faceSmiling: UIImage(systemName: "face.smiling")
        case .plus: UIImage(systemName: "plus")
        }
    }
}

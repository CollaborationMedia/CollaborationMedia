//
//  PosterImageView.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import UIKit

final class PosterImageView: UIImageView {
    
    init(width: CGFloat, height: CGFloat, image: UIImage?) {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

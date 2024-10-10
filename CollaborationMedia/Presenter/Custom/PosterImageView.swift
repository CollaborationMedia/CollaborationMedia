//
//  PosterImageView.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import UIKit
import SnapKit

final class PosterImageView: UIImageView {
    
    init(image: UIImage?, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = .red
        self.image = image
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

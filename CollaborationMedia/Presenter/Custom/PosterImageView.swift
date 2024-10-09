//
//  PosterImageView.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import UIKit
import SnapKit

final class PosterImageView: UIImageView {
    
    init(width: CGFloat, height: CGFloat, image: UIImage?, resize: Bool = false) {
        super.init(frame: CGRect())
        self.backgroundColor = .red
        self.image = image
        self.layer.cornerRadius = height >= 200 ? 10 : 5
        configLayout(height, width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLayout(_ height: CGFloat, _ width: CGFloat) {
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
}

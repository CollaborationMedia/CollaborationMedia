//
//  TestView.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import UIKit
import SnapKit

final class TestViewController: UIViewController {
 
    let posterImageView = PosterImageView(width: ScreenSize.width - 40,
                                          height: ScreenSize.height * 0.3,
                                          image: Image.squareAndArrowDown)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}

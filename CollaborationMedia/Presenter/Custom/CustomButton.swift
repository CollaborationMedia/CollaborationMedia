//
//  CustomButton.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/9/24.
//

import UIKit

final class CustomButton: UIButton {
    init(_ image: Image, _ title: String, _ foregroundColor: UIColor, _ backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.plain()
        config.image = image.rawValue
        config.title = title
        config.imagePadding = 8
        config.baseForegroundColor = foregroundColor
        config.background.backgroundColor = backgroundColor
        config.background.cornerRadius = 8
        
        self.configuration = config
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  PosterCell.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/10/24.
//

import UIKit
import SnapKit

final class PosterCell: BaseCollectionViewCell {
    private lazy var posterImageView = {
        let view = PosterImageView(cornerRadius: 5)
        self.contentView.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(data: PosterCellContent) {
        
    }
}

//
//  PosterCell.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class PosterCell: BaseCollectionViewCell {
    private let posterImageView = PosterImageView(cornerRadius: 5)
    
    override func configureLayout() {
        contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(data: PosterCellContent) {
        posterImageView.kf.setImage(with: URL(string: data.posterURL))
    }
}

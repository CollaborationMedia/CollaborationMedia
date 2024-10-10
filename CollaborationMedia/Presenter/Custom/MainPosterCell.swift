//
//  MainPosterCell.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/10/24.
//

import UIKit
import SnapKit

final class MainPosterCell: BaseCollectionViewCell {
    private let mainPosterImageView = PosterImageView(cornerRadius: 10)
    
    private let genresLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        view.text = "asdf" // dummy
        return view
    }()
    
    private let playButton = CustomButton(.play, "재생", .black, .white)
    private let plusButton = CustomButton(.plus, "내가 찜한 리스트", .white, .black)
    
    private lazy var buttonStack = {
        let view = UIStackView(arrangedSubviews: [playButton, plusButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 8
        return view
    }()
    
    override func configureLayout() {
        contentView.addSubview(mainPosterImageView)
        contentView.addSubview(genresLabel)
        contentView.addSubview(buttonStack)
        
        mainPosterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonStack.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(mainPosterImageView).inset(20)
        }
        
        genresLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(buttonStack.snp.top).offset(-8)
        }
    }
    
    func configure(data: PosterCellContent) {
        mainPosterImageView.image = UIImage(systemName: "star")
    }
}

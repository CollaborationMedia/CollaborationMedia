//
//  MainPosterCell.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/10/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class MainPosterCell: BaseCollectionViewCell {
    private let mainPosterImageView = PosterImageView(cornerRadius: 10)
    
    private let genresLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .white
        view.text = "더미 장르 데이터" // dummy
        return view
    }()
    
    let playButton = CustomButton(.play, "재생", .black, .white)
    private let plusButton = CustomButton(.plus, "내가 찜한 리스트", .white, .black)
    
    private lazy var buttonStack = {
        let view = UIStackView(arrangedSubviews: [playButton, plusButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 8
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
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
            $0.bottom.equalTo(buttonStack.snp.top).offset(-16)
        }
    }
    
    func configure(data: PosterCellContent) {
        mainPosterImageView.kf.setImage(with: URL(string: data.posterURL))
        
        if data.mediaType == "movie" {
            let genres = UserDefaultsManager.movieGenres
                .filter { data.genreIDs.contains($0.id) }
                .map { $0.name }
                .joined(separator: " ")

            genresLabel.text = genres
        } else if data.mediaType == "tv" {
            let genres = UserDefaultsManager.tvGenres
                .filter { data.genreIDs.contains($0.id) }
                .map { $0.name }
                .joined(separator: " ")

            genresLabel.text = genres
        }
    }
}

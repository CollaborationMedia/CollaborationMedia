//
//  DetailInfoCell.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/11/24.
//

import UIKit
import RxSwift

final class DetailInfoCell: BaseCollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    private let titleLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let voteAverageLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let playButton = {
        let button = CustomButton(
            Image.play,
            "재생",
            UIColor.ciGray,
            .white
        )
        return button
    }()
    
    private let saveButton = {
        let button = CustomButton(
            Image.plus,
            "저장",
            .white,
            UIColor.ciGray
        )
        return button
    }()
    
    private let overViewLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .white
        view.backgroundColor = .clear
        view.numberOfLines = 0
        return view
    }()
    
    private let castLabel = {
        let label = UILabel()
        label.text = "출연: "
        label.font = .systemFont(ofSize: 14)
        label.textColor = .ciGray
        label.textAlignment = .left
        return label
    }()
    
    private let creatorLabel = {
        let label = UILabel()
        label.text = "제작: "
        label.font = .systemFont(ofSize: 14)
        label.textColor = .ciGray
        label.textAlignment = .left
        return label
    }()
    
    override func configureLayout() {

        contentView.backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(overViewLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(creatorLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.horizontalEdges.equalToSuperview().inset(10)
        }
        voteAverageLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        playButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(playButton.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    func configCell(_ item: PosterContent) {
        titleLabel.text = item.title
        voteAverageLabel.text = String(format: "%.1f", item.voteAverage)
        overViewLabel.text = item.overview
        if let cast = item.credit.first, let base = castLabel.text {
            castLabel.text = base + cast
        }
        
        if let crew = item.credit.last, let base = creatorLabel.text {
            creatorLabel.text = base + crew
        }

    }
    
}

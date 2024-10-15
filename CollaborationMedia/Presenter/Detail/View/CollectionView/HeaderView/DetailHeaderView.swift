//
//  DetailHeaderView.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/11/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailHeaderView: UICollectionReusableView {
    
    private let imageView = {
        let view = PosterImageView(cornerRadius: 10)
        view.contentMode = .scaleToFill
        return view
    }()
    
    let titleLabel =  {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    func configLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configView() {
        backgroundColor = .clear
    }
    
    func configImage(_ rawUrl: String) {
        guard let url = URL(string: rawUrl) else {
            return
        }
        imageView.kf.setImage(with: url)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
    func configTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
        }
    }
    
}

//
//  TrendingViewController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit
import SnapKit

class TrendingViewController: BaseViewController {
    private let tvBarButtonItem = UIBarButtonItem(image: Image.sparklesTV.rawValue)
    private let searchBarButtonItem = UIBarButtonItem(image: Image.magnifyingglass.rawValue)
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .gray
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

private extension TrendingViewController {
    func setNavi() {
        navigationItem.rightBarButtonItems = [tvBarButtonItem, searchBarButtonItem]
        navigationController?.navigationBar.tintColor = .white
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitem: item, count: 1)
      
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

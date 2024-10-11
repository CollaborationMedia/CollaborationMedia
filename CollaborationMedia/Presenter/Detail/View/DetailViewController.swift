//
//  DetailViewController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator

protocol InfoCellDelegate {
    
    func inputPlayButton()
    
}


final class DetailViewController: BaseViewController {

    private var disposeBag = DisposeBag()
    
    private let input = DetailViewModel.Input()
    
    private var collectionView = DetailCollectionView(
        frame: .zero,
        collectionViewLayout: DetailCollectionView.createLayout()
    )
    
    private var headerRegistration: HeaderRegistration?
    
    private let detailInfoCellRegistration = CellRegistration<DetailInfoCell> { cell, indexPath, itemIdentifier in
        cell.configCell(itemIdentifier)
    }
    
    private let similarCellRegistration = CellRegistration<PosterCell> { cell, indexPath, itemIdentifier in
        cell.configure(data: itemIdentifier)
    }
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<DetailSectionModel> (
        configureCell: { [weak self] dataSource, collectionView, indexPath, item in
            
            let section = DetailSection.allCases[indexPath.section]
            
            if section == .detail, let cellRegistration = self?.detailInfoCellRegistration {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
            
            if section == .similar, let cellRegistration = self?.similarCellRegistration {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
            
            return UICollectionViewCell()
            
        }, configureSupplementaryView: { [weak self] dataSource, collectionView, kind, indexPath in
            
            guard let headerRegistration = self?.headerRegistration else {
                return UICollectionReusableView()
            }
            
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
           
        }
    )
    
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        bind()
    }
    
    override func configureHierachy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
        let output = viewModel.transform(input)
        
        input.loadContent.onNext(())
        
        let sections = [output.infoSection, output.similarSection]
        
        PublishSubject<DetailSectionModel>
            .combineLatest(sections)
            .map { [weak self] in
                self?.headerRegistration = self?.headerRegestration($0)
                return $0
            }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    private func headerRegestration(_ sections: [DetailSectionModel]) -> HeaderRegistration {
        HeaderRegistration(elementKind: UICollectionView.elementKindSectionHeader) {
            (supplementaryView, string, indexPath) in
            let section = DetailSection.allCases[indexPath.section]
            switch section {
            case .detail: 
                let url = sections[indexPath.section].items.first?.backdropURL ?? ""
                supplementaryView.configImage(url)
            case .similar:
                supplementaryView.configTitle(section.header)
            }
        }
    }

}

extension DetailViewController {
    
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<DetailHeaderView>
    typealias CellRegistration<T: BaseCollectionViewCell> = UICollectionView.CellRegistration<T, PosterContent>

}

extension DetailViewController: InfoCellDelegate {
    
    func inputPlayButton() {
        input.playButtonTapped.onNext(())
    }
    
}

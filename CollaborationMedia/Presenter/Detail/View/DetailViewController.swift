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

final class DetailViewController: BaseViewController {

    private var disposeBag = DisposeBag()
    
    private let input = DetailViewModel.Input()
    
    private var collectionView = DetailCollectionView(
        frame: .zero,
        collectionViewLayout: DetailCollectionView.createLayout()
    )

    private var viewModel: DetailViewModel
    
    fileprivate var dataSource: DataSource!
    
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
        configDataSource()
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
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
}

private extension DetailViewController {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<DetailSectionModel>
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<DetailHeaderView>
    typealias CellRegistration<T: BaseCollectionViewCell> = UICollectionView.CellRegistration<T, PosterContent>
    
    
    func configDataSource() {
    
        let headerRegistration = headerRegistration()
        let detailInfoCellRegistration = detailInfoCellRegistration()
        let similarCellRegistration = similarCellRegistration()
        
        dataSource = RxCollectionViewSectionedAnimatedDataSource<DetailSectionModel> (
            configureCell: { [weak self] dataSource, collectionView, indexPath, item in
              
                let section = DetailSection.allCases[indexPath.section]
                
                if section == .detail {
                    return collectionView.dequeueConfiguredReusableCell(
                        using: detailInfoCellRegistration,
                        for: indexPath,
                        item: item
                    )
                }
                
                if section == .similar {
                    return collectionView.dequeueConfiguredReusableCell(
                        using: similarCellRegistration,
                        for: indexPath,
                        item: item
                    )
                }
                
                return UICollectionViewCell()
                
            }, configureSupplementaryView: { [weak self] dataSource, collectionView, kind, indexPath in

                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: indexPath
                )
                
            }
        )
    }
    
    func headerRegistration() -> HeaderRegistration {
        HeaderRegistration(elementKind: UICollectionView.elementKindSectionHeader) {
            [weak self] (supplementaryView, string, indexPath) in
            let section = DetailSection.allCases[indexPath.section]
            switch section {
            case .detail:
                let url = self?.dataSource.sectionModels[indexPath.section].items.first?.backdropURL ?? ""
                supplementaryView.configImage(url)
            case .similar:
                supplementaryView.configTitle(section.header)
            }
        }
    }

    func detailInfoCellRegistration() -> CellRegistration<DetailInfoCell> {
        CellRegistration<DetailInfoCell> { cell, indexPath, itemIdentifier in
            cell.configCell(itemIdentifier)
            cell.playButton.rx.tap
                .bind(with: self, onNext: { owner, _ in
                    let contentType = itemIdentifier.mediaType == ContentType.movie.rawValue ?  ContentType.movie : ContentType.tv
                    
                    NetworkManager.request(VideoResponse.self, router: .video(contentType: contentType, id: itemIdentifier.id, query: VideoQuery())) { result in
                        if let path = result.results.first?.imagePath,
                           let url = URL(string: path) {
                            let videoVC = VideoViewController(url: url)
                            owner.present(videoVC, animated: true)
                        } else {
                            owner.view.makeToast("해당 작품의 동영상이 존재하지 않습니다.")
                        }
                    } failure: { error in
                        print(error)
                    }
                })
                .disposed(by: cell.disposeBag)
        }
        
    }
    
    func similarCellRegistration() -> CellRegistration<PosterCell> {
        CellRegistration<PosterCell> { cell, indexPath, itemIdentifier in
            cell.configure(data: itemIdentifier)
        }
    }

}

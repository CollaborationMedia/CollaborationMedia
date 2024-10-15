//
//  TrendingViewController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa
import Toast

class TrendingViewController: BaseViewController {
    private let tvBarButtonItem = UIBarButtonItem(image: Image.sparklesTV.rawValue)
    private let searchBarButtonItem = UIBarButtonItem(image: Image.magnifyingglass.rawValue)
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        self.view.addSubview(view)
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    private var dataSource: DataSource!
    private let viewModel: TrendingViewModel
    
    init(viewModel: TrendingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        configureDataSource()
        bind()
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        let posterSection = PublishRelay<[PosterSection]>()
        let input = TrendingViewModel.Input()
        let output = viewModel.transform(input: input)
        
        disposeBag.insert {
            posterSection
                .bind(to: collectionView.rx.items(dataSource: dataSource))
            
            Observable.combineLatest(output.main, output.trendingMovie, output.trendingTV)
                .bind { main, trendingMovie, trendingTV in
                    posterSection.accept([
                        PosterSection(model: .main, items: [main.randomElement() ?? PosterContent(id: 0, genreIDs: [], voteAverage: 0, overview: "")]),
                        PosterSection(model: .trendingMovie, items: trendingMovie),
                        PosterSection(model: .trendingTV, items: trendingTV)
                    ])
                }
        }
        collectionView.rx.itemSelected
            .map { [weak self] indexPath in
                let section = self?.dataSource.sectionModels[indexPath.section]
                let item = section?.items[indexPath.row]
                return item
            }
            .bind(with: self, onNext: { owner, content in
                guard let content else { return }
                let vc = DetailViewController(viewModel: DetailViewModel(content: content))
                owner.navigationController?.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

}

// MARK: UI
private extension TrendingViewController {
    func setNavi() {
        navigationItem.rightBarButtonItems = [tvBarButtonItem, searchBarButtonItem]
        navigationController?.navigationBar.tintColor = .white
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment -> NSCollectionLayoutSection? in
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            let sectionType = TrendingSection.allCases[sectionIndex]
            switch sectionType {
            case .main:
                return self?.createMainPosterSection()
            case .trendingMovie:
                let section = self?.createTrendingSection()
                section?.boundarySupplementaryItems = [header]
                return section
            case .trendingTV:
                let section = self?.createTrendingSection()
                section?.boundarySupplementaryItems = [header]
                return section
            }
        }
        
        return layout
    }
    
    func createMainPosterSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(500))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createTrendingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                               heightDimension: .absolute(120))

        var group = NSCollectionLayoutGroup(layoutSize: groupSize)
        
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        } else {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        }
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

// MARK: DataSource
private extension TrendingViewController {
    func configureDataSource() {
        let mainPosterCellRegistration = MainPosterCellRegistration { cell, indexPath, data in
            cell.configure(data: data)
            cell.playButton.rx.tap
                .bind(with: self) { owner, _ in
                    NetworkManager.request(VideoResponse.self, router: .video(contentType: data.mediaType == "movie" ? .movie : .tv, id: data.id, query: VideoQuery())) { result in
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

                }
                .disposed(by: cell.disposeBag)
        }
        
        let trendingCellRegistration = TrendingPosterCellRegistration { cell, indexPath, data in
            cell.configure(data: data)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] supplementaryView, elementKind, indexPath in
            guard let self else { return }
            let sectionItem = dataSource.sectionModels[indexPath.section].model
            
            var content = UIListContentConfiguration.groupedHeader()
            
            content.text = sectionItem.headerTitle
            content.textProperties.font = .systemFont(ofSize: 18)
            content.textProperties.color = .white
            
            supplementaryView.contentConfiguration = content
        }
        
        dataSource = DataSource(configureCell: { section, collectionView, indexPath, itemIdentifier in
            let sectionType = section.sectionModels[indexPath.section].model
            switch sectionType {
            case .main:
                return collectionView.dequeueConfiguredReusableCell(
                    using: mainPosterCellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
            case .trendingMovie:
                return collectionView.dequeueConfiguredReusableCell(
                    using: trendingCellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
            case .trendingTV:
                return collectionView.dequeueConfiguredReusableCell(
                    using: trendingCellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
            }
        }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        })
    }
}

extension TrendingViewController {
    enum TrendingSection: CaseIterable, IdentifiableType {
        case main
        case trendingMovie
        case trendingTV
        
        var headerTitle: String {
            switch self {
            case .main:
                ""
            case .trendingMovie:
                "지금 뜨는 영화"
            case .trendingTV:
                "지금 뜨는 TV 시리즈"
            }
        }
        
        var identity: UUID {
            switch self {
            case .main:
                UUID()
            case .trendingMovie:
                UUID()
            case .trendingTV:
                UUID()
            }
        }
    }
}

extension TrendingViewController {
    typealias PosterSection = AnimatableSectionModel<TrendingSection, PosterContent>
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<PosterSection>
    typealias MainPosterCellRegistration = UICollectionView.CellRegistration<MainPosterCell, PosterContent>
    typealias TrendingPosterCellRegistration = UICollectionView.CellRegistration<PosterCell, PosterContent>
}

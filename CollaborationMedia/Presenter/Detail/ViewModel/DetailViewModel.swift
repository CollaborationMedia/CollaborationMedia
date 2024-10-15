//
//  DetailViewModel.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    
    private var disposeBag = DisposeBag()
    
    private var output = Output()
    
    private var content: PosterContent
    
    init(content: PosterContent) {
        self.content = content
    }
    
    struct Input {
        var loadContent = PublishSubject<Void>()
        var playButtonTapped = PublishSubject<Void>()
        var saveButtonTapped = PublishSubject<Void>()
    }
    
    struct Output {
        var videoURL = PublishSubject<String>()
        var infoSection = BehaviorSubject<DetailSectionModel>(
            value: DetailSectionModel(header: DetailHeaderView(), items: [])
        )
        var similarSection = PublishSubject<DetailSectionModel>()
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadContent = input.loadContent.asDriver(onErrorJustReturn: ())

        loadContent
            .map { [weak self] in
                let contentType = self?.content.mediaType == ContentType.movie.rawValue ?  ContentType.movie : ContentType.tv
                return (contentType, CreditQuery())
            }
            .drive(with: self) { owner, requestInfo in
                let type = requestInfo.0 as ContentType
                let query = requestInfo.1 as CreditQuery
                let router: APIRouter = .credit(
                    contentType: type,
                    id: owner.content.id,
                    query: query
                )
                
                NetworkManager.request(CreditResponse.self, router: router) { result in
                    let actor = result.cast
                                .filter({ $0.knownForDepartment == "Acting" }).prefix(3)
                                .map { $0.name  }
                                .joined(separator: ", ")
                    let creator = result.crew
                            .filter({ $0.knownForDepartment == "Directing" }).prefix(3)
                            .map { $0.name }
                            .joined(separator: ", ")
                    owner.content.credit.append(actor)
                    owner.content.credit.append(creator)
                    let section = DetailSectionModel(header: DetailHeaderView(), items: [owner.content])
                    owner.output.infoSection.onNext(section)
                } failure: { error in
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        loadContent
            .map { [weak self] in
                let contentType = self?.content.mediaType == ContentType.movie.rawValue ?  ContentType.movie : ContentType.tv
                return (contentType, SimilarQuery(page: 1))
            }
            .drive(with: self) { owner, requestInfo in
                let type = requestInfo.0 as ContentType
                let query = requestInfo.1 as SimilarQuery
               
                let router: APIRouter = .similar(
                    contentType: type,
                    id: owner.content.id,
                    query: query
                )
             
                switch type {
                case .movie:
                    NetworkManager.request(TMDBResponse<Movie>.self, router: router) { result in
                        let section = DetailSectionModel(header: DetailHeaderView(),
                                                         items: result.results.map({ $0.posterItem }))
                        owner.output.similarSection.onNext(section)
                    } failure: { error in
                        print(error)
                    }
                case .tv:
                    NetworkManager.request(TMDBResponse<TVSeries>.self, router: router) { result in
                        let section = DetailSectionModel(header: DetailHeaderView(),
                                                         items: result.results.map({ $0.posterItem }))
                        owner.output.similarSection.onNext(section)
                    } failure: { error in
                        print(error)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.playButtonTapped
            .map { [weak self] in
                let contentType = self?.content.mediaType == ContentType.movie.rawValue ?
                ContentType.movie : ContentType.tv
                let id = self?.content.id ?? 0
                return ( contentType, id, VideoQuery() )
            }
            .bind(with: self) { owner, requestInfo in
                let router: APIRouter = .video(contentType: requestInfo.0, id: requestInfo.1, query: requestInfo.2)
                NetworkManager.request(VideoResponse.self, router: router,
                    success: { result in
                        guard let url = result.results.first?.imagePath else {
                            return
                        }
                        owner.output.videoURL.onNext(url)
                    },
                    failure: { error in
                        print(error)
                    }
                )
            }
            .disposed(by: disposeBag)
    
        return output
    }

    func configContent(_ content: PosterContent) {
        self.content = content
    }
    

}

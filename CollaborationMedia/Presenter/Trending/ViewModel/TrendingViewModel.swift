//
//  TrendingViewModel.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendingViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let main = BehaviorRelay<[PosterContent]>(value: [])
        let trendingMovie = BehaviorRelay<[PosterContent]>(value: [])
        let trendingTV = BehaviorRelay<[PosterContent]>(value: [])
        
        var posterData: [PosterContent] = []
        
        NetworkManager.request(TMDBResponse<Movie>.self, router: .trending(contentType: .movie, query: TrendingQuery())) { result in
            trendingMovie.accept(result.results.map { $0.posterItem })
            posterData.append(contentsOf: result.results.map { $0.posterItem })
            main.accept(posterData)
        } failure: { error in
            print(error)
        }
        
        NetworkManager.request(TMDBResponse<TVSeries>.self, router: .trending(contentType: .tv, query: TrendingQuery())) { result in
            trendingTV.accept(result.results.map { $0.posterItem })
            posterData.append(contentsOf: result.results.map { $0.posterItem })
            main.accept(posterData)
        } failure: { error in
            print(error)
        }

        return Output(
            main: main,
            trendingMovie: trendingMovie,
            trendingTV: trendingTV
        )
    }
}

extension TrendingViewModel {
    struct Input {
        
    }
    
    struct Output {
        let main: BehaviorRelay<[PosterContent]>
        let trendingMovie: BehaviorRelay<[PosterContent]>
        let trendingTV: BehaviorRelay<[PosterContent]>
    }
}

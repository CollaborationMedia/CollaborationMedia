//
//  TestViewController.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/10/24.
//


import UIKit

final class APITestViewController: BaseViewController {
    
    private var posterContentList: [PosterCellContent] = []
    
    private var listContentList: [ListCellContent] = []
    
    private var genreDict: [ContentType:[Genre]] = [:]
    
    private var castList: [Cast] = []
    
    private var crewList: [Cast] = []
    
    private var testMovieId = 533535
    
    private var testTVId = 84773
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        callTrendingAPI(object: Movie.self)
//        callSearchAPI(query: "스파", page: 1)
//        callSimilarAPI(object: TVSeries.self, id: testTVId, page: 1)
//        callGenreAPI(contentType: .tv)
//        callCreditAPI(contentType: .movie, id: testMovieId)
        callVedioAPI(contentType: .movie, id: testMovieId)
    }
    
    func callTrendingAPI<T: PosterCellContent>(object: T.Type) {
         
        let contentType: ContentType = object == Movie.self ? .movie : .tv
        let router: APIRouter = .trending(contentType: contentType,
                                          query: TrendingQuery())
        
        NetworkManager.request(TMDBResponse<T>.self,
            router: router,
            success: { [weak self] result in
                self?.posterContentList = result.results
                print(self?.posterContentList)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    // Search는 Movie만 검색하도록 명세되어 있음
    func callSearchAPI(query: String,
                       page: Int) {
        
        let router: APIRouter = .search(contentType: .movie,
                                        query: SearchQuery(query: query, page: page))
        
        NetworkManager.request(TMDBResponse<Movie>.self,
            router: router,
            success: {  [weak self] result in
                self?.listContentList = result.results
                print(self?.listContentList)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    // TMDBResponse<Movie>.self or TMDBResponse<TV>.self
    func callSimilarAPI<T: PosterCellContent>(object: T.Type, id: Int, page: Int) {
        
        let contentType: ContentType = object == Movie.self ? .movie : .tv
        let router: APIRouter = .similar(contentType: contentType,
                                         id: id,
                                         query: SimilarQuery(page: page))
        
        NetworkManager.request(TMDBResponse<T>.self,
            router: router,
            success: { [weak self] result in
                self?.posterContentList = result.results
                print(self?.posterContentList)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    func callGenreAPI(contentType: ContentType) {
        
        let router: APIRouter = .genreList(contentType: contentType, 
                                           query: GenreListQuery())
        
        NetworkManager.request(GenreResponse.self,
            router: router,
            success: { result in
                print(result)
            },
            failure: { error in
                print(error)
            }
        )
        
    }
    
    func callCreditAPI(contentType: ContentType, id: Int) {
        let router: APIRouter = .credit(contentType: contentType,
                                        id: id,
                                        query: CreditQuery())
        
        NetworkManager.request(CreditResponse.self,
            router: router,
            success: { result in
                print(result)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    func callVedioAPI(contentType: ContentType, id: Int) {
        
        let router: APIRouter = .video(contentType: contentType,
                                       id: id, 
                                       query: VideoQuery())
        
        NetworkManager.request(
            VideoResponse.self,
            router: router,
            success: { result in
                print(result.results)
            },
            failure: { error in
                print(error)
            }
        )
        
    }
    
}

//
//  DetailSectionModel.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/11/24.
//

import RxDataSources
import Differentiator
import UIKit


struct DetailContent: PosterCellContent, IdentifiableType, Hashable {
    var identity = UUID()
    var id: Int
    var mediaType: String?
    var title: String?
    var genreIDs: [Int]
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double
    var overview: String
//    var posterURL: String
//    var backdropURL: String
}

struct DetailSectionModel {
    var identity = UUID()
    var header: UICollectionReusableView
    var items: [Item]
}

extension DetailSectionModel: AnimatableSectionModelType {
    
    typealias Item = PosterContent
    typealias Identity = UUID
    
    init(original: DetailSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}

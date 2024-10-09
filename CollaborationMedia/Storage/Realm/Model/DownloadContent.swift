//
//  DownloadContent.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation
import RealmSwift

final class DownloadContent: Object, ListCellContent {

    @Persisted(primaryKey: true) var identifier: ObjectId
    @Persisted var id: Int
    @Persisted var mediaType: String
    @Persisted var title: String
    @Persisted var posterPath: String?
    @Persisted var backdropPath: String?
    @Persisted var voteAverage: Double
    @Persisted var overview: String
    
    convenience init(id: Int, mediaType: String, title: String, posterPath: String?, backdropPath: String?, voteAverage: Double, overview: String) {
        self.init()
        self.id = id
        self.mediaType = mediaType
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
    }
    
}

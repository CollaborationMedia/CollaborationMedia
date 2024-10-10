//
//  Repository.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import Foundation
import RealmSwift

final class RealmRepository<T: Object> {
    private let realm: Realm
    
    init() throws {
        do {
            self.realm = try Realm()
        } catch {
            throw error
        }
    }
    
    func createItem(data: T) throws {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            throw error
        }
    }
    
    func fetchAll() -> [T] {
        let results = realm.objects(T.self)
        return Array(results)
    }
    
    func fetchByMediaType(mediaType: String) -> [T] where T: DownloadContent{
        let results = realm.objects(T.self).where { $0.mediaType.contains(mediaType, options: .caseInsensitive)}
        return Array(results)
    }
    
    func deleteItem(data: T) throws {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            throw error
        }
    }
}

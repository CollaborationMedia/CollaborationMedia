//
//  UserDefault.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/11/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    enum UserDefaultKeys: String {
        case movieGenres, tvGenres
    }

    let key: UserDefaultKeys
    let defaultValue: T
    let isCustomObject: Bool
    let userDefaults = UserDefaults.standard
    
    var wrappedValue: T {
        get {
            if isCustomObject {
                guard let data = self.userDefaults.data(forKey: key.rawValue) else { return defaultValue }
                let session = try? JSONDecoder().decode(T.self, from: data)
                return session ?? defaultValue
            } else {
                return self.userDefaults.object(forKey: self.key.rawValue) as? T ?? self.defaultValue
            }
        }
        
        set {
            if isCustomObject {
                let data = try? JSONEncoder().encode(newValue)
                self.userDefaults.set(data, forKey: self.key.rawValue)
            } else {
                self.userDefaults.set(newValue, forKey: self.key.rawValue)
            }
        }
    }
}

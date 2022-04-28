//
//  GameEntity.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var releaseDate: String = ""
    @Persisted var imageBackground: String?
    @Persisted var rating: Double?
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}

//
//  LocaleDataSource.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func getFavorites() -> Observable<[GameEntity]>
    func getFavorite(id: String) -> Observable<GameEntity?>
    func addFavorite(from game: GameEntity) -> Observable<Bool>
    func deleteFavorite(id: String) -> Observable<Bool>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let shared: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getFavorite(id: String) -> Observable<GameEntity?> {
        return Observable<GameEntity?>.create { observer in
            if let realm = self.realm {
                if let object = realm.objects(GameEntity.self).filter("id = \(id)").first {
                    observer.onNext(object)
                    observer.onCompleted()
                } else {
                    observer.onNext(nil)
                    observer.onCompleted()
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getFavorites() -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                observer.onNext(games.toArray(ofType: GameEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addFavorite(from game: GameEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func deleteFavorite(id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                if let object = realm.objects(GameEntity.self).filter("id = \(id)").first {
                    do {
                        try realm.write {
                            realm.delete(object)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    } catch {
                        observer.onError(DatabaseError.requestFailed)
                    }
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}

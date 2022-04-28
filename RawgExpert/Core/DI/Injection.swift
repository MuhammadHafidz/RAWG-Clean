//
//  Injection.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RealmSwift
import Swinject

final class Injection: NSObject {
    let container: Container = Container()
    
    override init() {
        container.register(GameRepositoryProtocol.self) { _ in
            let realm = try? Realm()
            let locale: LocaleDataSource = LocaleDataSource.shared(realm)
            let remote: RemoteDataSource = RemoteDataSource.shared
            return GameRepository.sharedInstance(locale, remote)
        }
        
        container.register(HomeUseCase.self) { resolver in
            return HomeInteractor(repository: resolver.resolve(GameRepositoryProtocol.self)!)
        }
        
        container.register(FavoriteUseCase.self) { resolver in
            return FavoriteInteractor(repository: resolver.resolve(GameRepositoryProtocol.self)!)
        }
        
        container.register(DetailUseCase.self) { resolver, game in
            return DetailInteractor(repository: resolver.resolve(GameRepositoryProtocol.self)!, game: game)
        }
        
    }
    
    func provideHome() -> HomeUseCase {
        return container.resolve(HomeUseCase.self)!
    }
    
    func provideDetail(game: GameModel) -> DetailUseCase {
        return container.resolve(DetailUseCase.self, argument: game)!
    }
    
    func provideFavorite() -> FavoriteUseCase {
        return container.resolve(FavoriteUseCase.self)!
    }
    
}

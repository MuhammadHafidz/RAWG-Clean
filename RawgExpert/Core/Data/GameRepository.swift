//
//  GameRepository.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol GameRepositoryProtocol {
    func getGames() -> Observable<[GameModel]>
    func getDetailGames(id: String) -> Observable<GameDetailModel>
    func searchGame(query: String) -> Observable<[GameModel]>
    func getFavorites() -> Observable<[GameModel]>
    func getFavorite(id: String) -> Observable<GameModel?>
    func addFavorite(from game: GameDetailModel) -> Observable<Bool>
    func deleteFavorite(id: String) -> Observable<Bool>
}

final class GameRepository: NSObject {
    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGames() -> Observable<[GameModel]> {
        return self.remote.getGames()
            .map { GameMapper.gameResponseToModel(input: $0) }
    }
    
    func getDetailGames(id: String) -> Observable<GameDetailModel> {
        return self.remote.detailGame(id: id)
            .map { GameMapper.gameDetailResponseToModel(input: $0)}
    }
    
    func searchGame(query: String) -> Observable<[GameModel]> {
        return self.remote.searchGame(query: query)
            .map { GameMapper.gameResponseToModel(input: $0) }
    }
    
    func getFavorites() -> Observable<[GameModel]> {
        return self.locale.getFavorites()
            .map { GameMapper.gameEntityToModel(input: $0)}
    }
    
    func addFavorite(from game: GameDetailModel) -> Observable<Bool> {
        return self.locale.addFavorite(from: GameMapper.detailModelToGameEntity(input: game))
    }
    
    func getFavorite(id: String) -> Observable<GameModel?> {
        return self.locale.getFavorite(id: id)
            .map { GameMapper.gameEntityToModel(input: $0)}
    }
    
    func deleteFavorite(id: String) -> Observable<Bool> {
        return self.locale.deleteFavorite(id: id)
    }
    
}

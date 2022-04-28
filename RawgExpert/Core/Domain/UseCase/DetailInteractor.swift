//
//  DetailUseCase.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getGame() -> GameModel
    func getDetailGame(id: String) -> Observable<GameDetailModel>
    func addFavorite(game: GameDetailModel) -> Observable<Bool>
    func deleteFavorite(id: String) -> Observable<Bool>
    func checkFavorite(id: String) -> Observable<GameModel?>
}

class DetailInteractor: DetailUseCase {
    private let game: GameModel
    private let repository: GameRepositoryProtocol
    
    required init( repository: GameRepositoryProtocol, game: GameModel) {
        self.repository = repository
        self.game = game
    }
    
    func getDetailGame(id: String) -> Observable<GameDetailModel> {
        return repository.getDetailGames(id: id)
    }
    
    func addFavorite(game: GameDetailModel) -> Observable<Bool> {
        return repository.addFavorite(from: game)
    }
    
    func deleteFavorite(id: String) -> Observable<Bool> {
        return repository.deleteFavorite(id: id)
    }
    
    func checkFavorite(id: String) -> Observable<GameModel?> {
        return repository.getFavorite(id: id)
    }
    
    func getGame() -> GameModel {
        return game
    }
}

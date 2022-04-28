//
//  FavoriteUseCase.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteGames() -> Observable<[GameModel]>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GameRepositoryProtocol
    
    required init( repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> Observable<[GameModel]> {
        return repository.getFavorites()
    }
}

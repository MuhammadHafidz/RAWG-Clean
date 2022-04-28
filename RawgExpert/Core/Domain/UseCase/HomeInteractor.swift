//
//  HomeUseCase.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getGames() -> Observable<[GameModel]>
    func searchGames(query: String) -> Observable<[GameModel]>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol
    
    required init( repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> Observable<[GameModel]> {
        return repository.getGames()
    }
    
    func searchGames(query: String) -> Observable<[GameModel]> {
        return repository.searchGame(query: query)
    }
}

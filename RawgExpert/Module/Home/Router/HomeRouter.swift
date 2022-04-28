//
//  HomeRouter.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
    func makeFavoriteView() -> some View {
        let favoriteUseCase = Injection.init().provideFavorite()
        let presenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        return FavoriteView(presenter: presenter)
    }
    
    func makeProfileView() -> some View {
        return ProfileView()
    }
    
}

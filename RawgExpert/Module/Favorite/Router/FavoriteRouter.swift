//
//  FavoriteRouter.swift
//  RawgExpert
//
//  Created by Enygma System on 25/04/22.
//

import SwiftUI

class FavoriteRouter {
    func makeDetailFavoriteView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
}

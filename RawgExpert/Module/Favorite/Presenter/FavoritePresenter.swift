//
//  FavoritePresenter.swift
//  RawgExpert
//
//  Created by Enygma System on 25/04/22.
//

import Foundation

import SwiftUI
import RxSwift

class FavoritePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var loadingState: Bool = false
    @Published var errorState = false
    @Published var errorMessage = ""
    @Published var favoriteGames = [GameModel]()
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoriteData() {
        loadingState = true
        favoriteUseCase.getFavoriteGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.favoriteGames = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func toDetailFavoriteLinkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailFavoriteView(for: game)) { content() }
    }
}

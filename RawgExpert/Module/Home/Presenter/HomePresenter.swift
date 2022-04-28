//
//  HomePresenter.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import RxSwift

class HomePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var listGames: [GameModel] = []
    @Published var searchGames: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var searchText = ""
    @Published var loadingState: Bool = false
    @Published var errorState: Bool = false
    let searchTextPublish = PublishSubject<String>()
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        initSearchBar()
    }
    
    func initSearchBar() {
        searchTextPublish.subscribe(
            onNext: { text in
                if !text.isEmpty {
                    self.listGames = []
                    self.loadingState = true
                } else {
                    self.listGames = self.games
                }
            }
        ).disposed(by: disposeBag)
    }
    
    func getAllGame() {
        loadingState = true
        homeUseCase.getGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result
                self.listGames = self.games
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func searchGame() {
        loadingState = true
        homeUseCase.searchGames(query: searchText)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.searchGames = result
                self.listGames = self.searchGames
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func toDetailLinkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: game)) { content() }
    }
    
    func toFavoriteLinkBuilder<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeFavoriteView) { content() }
    }
    
    func toProfileLinkBuilder<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeProfileView) { content() }
    }
    
}

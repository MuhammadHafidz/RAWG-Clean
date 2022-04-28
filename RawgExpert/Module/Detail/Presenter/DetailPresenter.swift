//
//  DetailPresenter.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import RxSwift

class DetailPresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    
    @Published var game: GameModel
    @Published var gameDetail: GameDetailModel?
    @Published var loadingState: Bool = false
    @Published var errorState: Bool = false
    @Published var errorMessage: String = ""
    @Published var isFavorite: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        game = detailUseCase.getGame()
    }
    
    func getDetail() {
        loadingState = true
        detailUseCase.getDetailGame(id: String(self.game.id))
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameDetail = result
                self.checkFavorite()
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func checkFavorite() {
        loadingState = true
        detailUseCase.checkFavorite(id: String(self.game.id))
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                if result != nil {
                    self.isFavorite = true
                } else {
                    self.isFavorite = false
                }
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func addFavorite() {
        detailUseCase.addFavorite(game: gameDetail!)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func deleteFavorite() {
        detailUseCase.deleteFavorite(id: String(self.game.id))
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = !result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.errorState = true
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}

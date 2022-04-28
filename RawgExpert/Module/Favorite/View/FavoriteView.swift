//
//  FavoriteView.swift
//  RawgExpert
//
//  Created by Enygma System on 25/04/22.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            List(presenter.favoriteGames, id: \.id) { game in
                ZStack {
                    GameRow(game: game)
                    self.presenter.toDetailFavoriteLinkBuilder(for: game) {
                        EmptyView()
                    }
                }
                .padding(.all, 8.0)
                .listRowInsets(EdgeInsets())
                .listStyle(PlainListStyle())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.black.opacity(0))
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
            .onAppear {
                presenter.getFavoriteData()
            }
            .alert(isPresented: self.$presenter.errorState) {
                Alert(title: Text("Error"), message: Text(presenter.errorMessage), dismissButton: .cancel())
            }
            if presenter.favoriteGames.isEmpty {
                Text("You don't favorite anything")
            }
            IndicatorView(tintColor: .black, scaleSize: 2.0)
                .padding(.bottom).hidden(!self.presenter.loadingState)
        }
    }
}

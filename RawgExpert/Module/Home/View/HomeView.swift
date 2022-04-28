//
//  HomeView.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import RxSwift

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack {
            NavigationView {
                List(presenter.listGames, id: \.id) { game in
                    ZStack {
                        GameRow(game: game)
                        self.presenter.toDetailLinkBuilder(for: game) {
                            EmptyView()
                        }
                    }
                    .padding(.all, 8.0)
                    .listRowInsets(EdgeInsets())
                    .listStyle(PlainListStyle())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.black.opacity(0))
                }
                .navigationBarTitle("RAWG", displayMode: .automatic)
                .navigationBarItems(
                    trailing:
                        HStack {
                            Button {
                                print("Open Favorite")
                            } label: {
                                self.presenter.toFavoriteLinkBuilder {
                                    Image(systemName: "heart.fill").imageScale(.large)
                                        .tint(.black)
                                }
                            }
                            Button {
                                print("Open Profile")
                            } label: {
                                self.presenter.toProfileLinkBuilder {
                                    Image(systemName: "person.crop.circle.fill").imageScale(.large)
                                        .tint(.black)
                                }
                            }
                        }
                )
                .onAppear {
                    if presenter.listGames.isEmpty {
                        presenter.getAllGame()
                    }
                }
                .alert(isPresented: $presenter.errorState) {
                    Alert(title: Text("Error"), message: Text(presenter.errorMessage), dismissButton: .cancel())
                }
            }
            .searchable(text: $presenter.searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search Game")
            .onChange(of: presenter.searchText) { text in
                presenter.searchTextPublish.onNext(text)
            }
            .onSubmit(of: .search) {
                presenter.searchGame()
            }
            IndicatorView(tintColor: .black, scaleSize: 2.0)
                .padding(.bottom).hidden(!presenter.loadingState)
        }
    }
}

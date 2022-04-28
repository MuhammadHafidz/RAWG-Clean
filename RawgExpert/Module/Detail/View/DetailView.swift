//
//  DetailView.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.60).ignoresSafeArea()
            ScrollView {
                if presenter.gameDetail != nil {
                    VStack(alignment: .leading) {
                        if presenter.gameDetail?.image != nil {
                            imageHeader
                        }
                        Text(presenter.gameDetail?.name ?? "-")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.vertical, 8.0)
                        StarsView(rating: presenter.gameDetail?.rating ?? 0)
                        HStack {
                            VStack(alignment: .center) {
                                Text("Metascore")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                Text((presenter.gameDetail?.metacritic != nil) ?
                                     String((presenter.gameDetail?.metacritic)!): "-")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.top, 4.0)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center) {
                                Text("Playtime")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                Text((presenter.gameDetail?.playtime != nil) ?
                                     String((presenter.gameDetail?.playtime)!): "-")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.top, 4.0)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center) {
                                Text("Rating")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                Text((presenter.gameDetail?.esrbRating) ?? "-")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.top, 4.0)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }.padding(.top, 20)
                        
                        Group {
                            Text("Release Date")
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .bold))
                                .padding(.top, 8.0)
                            Text(presenter.gameDetail?.releaseDate ?? "")
                                .foregroundColor(Color.white)
                                .font(.system(size: 12, weight: .regular))
                                .padding(.top, 1.0)
                            if presenter.gameDetail?.platforms != nil {
                                Text("Platform")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(presenter.gameDetail?.platforms ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                            if presenter.gameDetail?.genres != nil {
                                Text("Genre")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(presenter.gameDetail?.genres ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                        }
                        Group {
                            if presenter.gameDetail?.developers != nil {
                                Text("Developer")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(presenter.gameDetail?.developers ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                            if presenter.gameDetail?.publishers != nil {
                                Text("Publisher")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(presenter.gameDetail?.publishers ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                            if presenter.gameDetail?.description != nil {
                                Text("Description")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(presenter.gameDetail?.description ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                        }
                        if presenter.gameDetail?.urlWeb != nil {
                            Button {
                                let url = URL(string: (presenter.gameDetail?.urlWeb)!)
                                if UIApplication.shared.canOpenURL(url!) {
                                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                                }
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Open Website")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue.cornerRadius(10))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }.padding(.top)
                        }
                    }
                    .navigationBarItems(
                        trailing:
                            HStack {
                                if presenter.isFavorite {
                                    Button {
                                        presenter.deleteFavorite()
                                    } label: {
                                        Image(systemName: "heart.fill").imageScale(.large)
                                            .tint(.blue)
                                    }
                                } else {
                                    Button {
                                        presenter.addFavorite()
                                    } label: {
                                        Image(systemName: "heart").imageScale(.large)
                                            .tint(.blue)
                                    }
                                }
                            }
                    )
                    .navigationBarTitle("", displayMode: .inline)
                    .padding([.leading, .bottom, .trailing], 20)
                }
            }
            IndicatorView(tintColor: .white, scaleSize: 2.0)
                .padding(.bottom).hidden(!presenter.loadingState)
        }
        .onAppear {
            presenter.getDetail()
        }
        .alert(isPresented: self.$presenter.errorState) {
            Alert(title: Text("Error"), message: Text(presenter.errorMessage), dismissButton: .cancel())
        }
        .background(
            background
        )
    }
}

extension DetailView {
    var background: some View {
        WebImage(url: URL(string: presenter.gameDetail?.imageBackground ?? "" ))
            .resizable()
            .placeholder {
                Color.gray.opacity(0.1)
                    .cornerRadius(25)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            }
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
    }
    
    var imageHeader: some View {
        WebImage(url: URL(string: presenter.gameDetail?.imageBackground ?? "" ))
            .resizable()
            .placeholder {
                Color.gray.opacity(0.1)
                    .cornerRadius(25)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            }
            .indicator(.activity)
            .frame(height: 180)
            .cornerRadius(20)
            .shadow(color: .white, radius: 4)
            .aspectRatio(contentMode: .fill)
            .padding(.top, 20)
    }
    
}

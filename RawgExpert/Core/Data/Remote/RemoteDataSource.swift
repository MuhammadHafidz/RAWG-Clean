//
//  RemoteDataSource.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    func getGames() -> Observable<[GameResponse]>
    func searchGame(query: String) -> Observable<[GameResponse]>
    func detailGame(id: String) -> Observable<GameDetailResponse>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    static let shared: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGames() -> Observable<[GameResponse]> {
        let parameters = ["key": API.apiKey()]
        return Observable<[GameResponse]>.create { observer in
            if let url = URL(string: EndPoints.Gets.games.url) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val.results ?? [])
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func searchGame(query: String) -> Observable<[GameResponse]> {
        let parameters = [
            "key": API.apiKey(),
            "search": query
        ]
        return Observable<[GameResponse]>.create { observer in
            if let url = URL(string: EndPoints.Gets.search.url) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val.results ?? [])
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func detailGame(id: String) -> Observable<GameDetailResponse> {
        let parameters = [
            "key": API.apiKey()
        ]
        return Observable<GameDetailResponse>.create { observer in
            if let url = URL(string: EndPoints.Gets.detail(id: id).url) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
}

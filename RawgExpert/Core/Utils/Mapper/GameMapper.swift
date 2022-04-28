//
//  GameMapper.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

final class GameMapper {
    static func gameResponseToModel(
        input gameResponse: [GameResponse]
    ) -> [GameModel] {
        return gameResponse.map { data in
            return GameModel(
                id: data.id,
                name: data.name,
                releaseDate: data.releaseDate,
                rating: data.rating,
                imageBackground: data.imageBackground ?? ""
            )
        }
    }
    
    static func gameDetailResponseToModel(
        input gameResponse: GameDetailResponse
    ) -> GameDetailModel {
        return GameDetailModel(
            id: gameResponse.id,
            name: gameResponse.name,
            releaseDate: gameResponse.releaseDate,
            rating: gameResponse.rating,
            imageBackground: gameResponse.imageBackground ?? "",
            image: gameResponse.image ?? "",
            metacritic: gameResponse.metacritic != nil ? String(gameResponse.metacritic!) : "-",
            playtime: gameResponse.playtime != nil ? String(gameResponse.playtime!) : "-",
            esrbRating: gameResponse.esrbRating ?? "",
            platforms: gameResponse.platforms ?? "",
            genres: gameResponse.genres ?? "",
            developers: gameResponse.developers ?? "",
            publishers: gameResponse.publishers ?? "",
            description: gameResponse.description ?? "",
            urlWeb: gameResponse.urlWeb ?? ""
        )
    }
    
    static func detailModelToGameEntity(
        input gameDetail: GameDetailModel
    ) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = gameDetail.id
        newGame.name = gameDetail.name
        newGame.releaseDate = gameDetail.releaseDate
        newGame.rating = gameDetail.rating ?? 0.0
        newGame.imageBackground = gameDetail.imageBackground ?? ""
        return newGame
    }
    
    static func gameEntityToModel(
        input gameEntity: [GameEntity]
    ) -> [GameModel] {
        return gameEntity.map { data in
            return GameModel(
                id: data.id,
                name: data.name,
                releaseDate: data.releaseDate,
                rating: data.rating,
                imageBackground: data.imageBackground
            )
        }
    }
    
    static func gameEntityToModel(
        input gameEntity: GameEntity?
    ) -> GameModel? {
        if let data = gameEntity {
            return GameModel(
                id: data.id,
                name: data.name,
                releaseDate: data.releaseDate,
                rating: data.rating,
                imageBackground: data.imageBackground
            )
        } else {
            return nil
        }
    }
}

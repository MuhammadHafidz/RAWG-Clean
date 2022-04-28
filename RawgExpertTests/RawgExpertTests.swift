//
//  RawgExpertTests.swift
//  RawgExpertTests
//
//  Created by Enygma System on 25/04/22.
//

import XCTest

@testable import RawgExpert
class RawgExpertTests: XCTestCase {
    
    var gameModel = GameModel(
        id: 3498,
        name: "Grand Theft Auto V",
        releaseDate: "Sep,17 2013",
        rating: 4.48,
        imageBackground: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
    )

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    }
    
    func testGameModelName() throws {
        let name = "GTA-V"
        gameModel.name = name
        XCTAssertEqual(gameModel.name, "GTA-V", "Failed to change Model Name to \(name)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

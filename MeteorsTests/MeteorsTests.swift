//
//  MeteorsTests.swift
//  MeteorsTests
//
//  Created by Ulaş Sancak on 29.09.2021.
//

import XCTest
@testable import Meteors

class MeteorsTests: XCTestCase {
    
    var meteors: [Meteor]!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let path = Bundle(for: type(of: self )).path(forResource: "test_meteors", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        meteors = try! data.toDecodable()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddToFavorite() {
        let repository = MeteorsLocalRepository()
        let meteor = meteors[0]
        repository.addToFavorite(meteor: meteor) { _ in}
        XCTAssertTrue(repository.meteors.contains(meteor), "Meteor could not be added to favorite")
    }
    
    func testAddToFavoriteWithViewModel() {
        let repository = MeteorsLocalRepository()
        let viewModel = MeteorsViewModel(repository: repository)
        let meteor = meteors[0]
        viewModel.add(meteor: meteor)
        XCTAssertTrue(repository.meteors.contains(meteor), "Meteor could not be added to favorite")
    }
    
    func testRemoveFromFavorites() {
        let repository = MeteorsLocalRepository()
        repository.meteors = meteors
        let meteor = repository.meteors[0]
        repository.removeFromFavorite(meteor: meteor) { _ in}
        XCTAssertFalse(repository.meteors.contains(meteor), "Meteor could not be removed from favorite")
    }
    
    func testRemoveFromFavoritesWithViewModel() {
        let repository = MeteorsLocalRepository()
        let viewModel = MeteorsViewModel(repository: repository)
        repository.meteors = meteors
        let index = 0
        let meteor = repository.meteors[index]
        viewModel.removeMeteor(at: index)
        XCTAssertFalse(repository.meteors.contains(meteor), "Meteor could not be removed from favorite")
    }
    
    func testDetailAddToFavorite() {
        let repository = MeteorsLocalRepository()
        repository.meteors = meteors
        let meteor = repository.meteors[0]
        let detailViewModel = MeteorDetailViewModel(repository: repository, meteor: meteor)
        detailViewModel.addToFavorites()
        XCTAssertTrue(repository.meteors.contains(meteor), "Meteor could not be added to favorite")
    }
    
    func testCheckingFavorite() {
        let repository = MeteorsLocalRepository()
        repository.meteors = meteors
        let meteor = repository.meteors[0]
        let detailViewModel = MeteorDetailViewModel(repository: repository, meteor: meteor)
        detailViewModel.addToFavorites()
        let isFavorite = detailViewModel.isFavorited
        XCTAssertTrue(isFavorite, "isFavorite should be true")
    }
    
    func testCheckingFavoriteFail() {
        let repository = MeteorsLocalRepository()
        repository.meteors = meteors
        let meteor = repository.meteors[0]
        let detailViewModel = MeteorDetailViewModel(repository: repository, meteor: meteor)
        detailViewModel.addToFavorites()
        detailViewModel.removeFromFavorites()
        let isFavorite = detailViewModel.isFavorited
        XCTAssertFalse(isFavorite, "isFavorite should be false")
    }
    
    func testDetailRemoveFromFavorites() {
        let repository = MeteorsLocalRepository()
        repository.meteors = meteors
        let meteor = repository.meteors[0]
        let detailViewModel = MeteorDetailViewModel(repository: repository, meteor: meteor)
        detailViewModel.addToFavorites()
        detailViewModel.removeFromFavorites()
        XCTAssertFalse(repository.meteors.contains(meteor), "Meteor could not be removed from favorite")
    }

}

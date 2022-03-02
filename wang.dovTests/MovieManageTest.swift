//
//  MovieManageTest.swift
//  wang.dovTests
//
//  Created by i564206 on 2022/2/27.
//

import XCTest
@testable import wang_dov
class MovieManageTest: XCTestCase {
    
    var mvm: MovieManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mvm = MovieManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit_MovieToSee_InitRight(){
        XCTAssertEqual(mvm.moviesToSeeCount, 0)
    }
    
    func testAdd_MovieToSee_Up(){
        let testAddMovie = Movie(title: "Sci-Fi", releaseDate: "20190203")
        mvm.addMovie(movie: testAddMovie)
        XCTAssertEqual(mvm.moviesToSeeCount, 1)
        
    }
    
    func testCheckOffMovie_UpdateMovieManagerCount(){
        mvm.addMovie(movie: Movie(title: "Action Adventure"))
        mvm.checkOffMovieAtIndex(index: 0)
        
        XCTAssertEqual(mvm.moviesToSeeCount, 0)
        XCTAssertEqual(mvm.moviesBeSawCount, 1)
        
    }

}

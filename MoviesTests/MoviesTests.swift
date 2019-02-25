//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Shimaa Hassan on 2/22/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSegmentsTap() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let segments = ["All Movies","My Movies"]
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        controller.loadViewIfNeeded()
        controller.segmentControl.selectedSegmentIndex = 0
        let firstSegment = controller.segmentControl.titleForSegment(at: 0)
        let secondSegment = controller.segmentControl.titleForSegment(at: 1)
        XCTAssertEqual(segments[0], firstSegment)
        XCTAssertEqual(segments[1], secondSegment)

    }
    func testAddMovie() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        controller.loadViewIfNeeded()
        controller.AddMovie(controller.addMovieButton)
        XCTAssert(!controller.addView.isHidden, "add button doesn't work!")
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

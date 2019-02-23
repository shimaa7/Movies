//
//  DS & Algorithms.swift
//  Movies
//
//  Created by Shimaa Hassan on 2/22/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import Foundation

// movie struct
struct Movie{
    var title: String
    var overview: String
    var poster: String
    var date: String
}

// movie segment
enum MovieType {
    case AllMovies
    case MyMovies
}

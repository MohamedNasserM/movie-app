//
//  Movie.swift
//  MovieApp
//
//  Created by Esraa Hassan on 10/2/20.
//  Copyright © 2020 jets. All rights reserved.
//

import Foundation

// MARK: - ResultWrapperElement
struct Movie: Codable {
    let title: String
    let image: String
    let rating: Double
    let releaseYear: Int
    let genre: [String]
}

typealias Movies = [Movie]

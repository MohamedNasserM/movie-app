

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

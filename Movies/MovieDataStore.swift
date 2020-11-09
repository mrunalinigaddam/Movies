//
//  MovieDataStore.swift
//  Movies
//
//  Created by Mrunalini on 07/11/20.
//  Copyright © 2020 Mrunalini. All rights reserved.
//

import Foundation

struct MovieDataStore: Codable {
    var movies: [Movie]
}

struct Movie: Codable {
    var name: String
    var url: String
    var desc: String
}

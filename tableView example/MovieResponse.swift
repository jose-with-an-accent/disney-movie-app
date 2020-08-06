//
//  MovieResponse.swift
//  tableView example
//
//  Created by jose sanchez on 8/4/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    let popularity: Float?
    let vote_count: Int
    let video: Bool?
    let poster_path: String?
    let id: Int?
    let adult: Bool?
    let backdrop_path: String?
    let original_language: String
    let original_title: String
    let genre_ids: Array<Int>?
    let title: String
    let vote_average: Float
    let overview: String
    let release_date: String
}
struct SearchResponse: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: Array<MovieResponse>
}


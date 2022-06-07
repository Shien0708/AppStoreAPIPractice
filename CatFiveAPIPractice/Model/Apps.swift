//
//  Apps.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case requestFailed(Error)
    case invalidData
    case invalidResponse
}

struct Apps: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var results: [AppsResult]
}

struct AppsResult: Codable {
    var name: String
    var artistName: String
    var artworkUrl100: URL
    var id: String
}

//
//  AppDetails.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/7.
//

import Foundation

struct AppDetail: Decodable {
    var results: [DetailResult]
}

struct DetailResult: Decodable {
    var screenshotUrls: [URL]
    var artworkUrl100: URL
    var languageCodesISO2A: [String]
    var fileSizeBytes: String
    var formattedPrice: String?
    var contentAdvisoryRating: String
    var averageUserRating: Float
    var userRatingCountForCurrentVersion: Int
    var trackName: String
    var sellerName: String
    var releaseNotes: String?
    var description: String
    var version: String
    var primaryGenreName: String
}




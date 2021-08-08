//
//  MovieList.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import Foundation

struct MovieList: Codable, Identifiable {
    let id: Int
    let thumbnailURL: String
    let name: String
    let watchedPercentage: Int
    let type: String
    let bucketName: String
    
    static let example = MovieList(id: 1, thumbnailURL: "test url", name: "Test Movie", watchedPercentage: 20, type: "movie", bucketName: "recommended")
}

//Dir["*.jpg"].each_with_index.each do |f, i|
// filename = File.basename(f, File.extname(f))
// File.rename(f, i.to_s + File.extname(f))
// end

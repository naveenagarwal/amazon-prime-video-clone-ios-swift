//
//  MovieListViewModel.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import Foundation

class MovieListViewModel{
    
    static let host: String = "localhost:3000"

    static func fetchMovieList(subPath: String, bucketName: String = "", pageNumber: Int = 0, limit: Int = 5) -> String {
        var url = "http://\(host)/\(subPath)?&_page=\(pageNumber)"
        
        if bucketName.count > 0 {
            url += "&bucketName=\(bucketName)"
        }
        if limit > 0 {
            url += "&_limit=\(limit)"
        }
        
        return url
    }
    
    static func formatURL(url: String) -> String {
        return url.replacingOccurrences(of: "http://localhost:3000", with: "http://\(host)")
    }
    
    static func getVideoDetailsURL(video: MovieList) -> String{
//        return "http://\(host)/videoDetails/\(video.id)"
        return "http://\(host)/videodetails/1"
    }
    
}

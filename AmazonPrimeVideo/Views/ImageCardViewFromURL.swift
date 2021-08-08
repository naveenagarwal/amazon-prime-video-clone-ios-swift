//
//  ImageCardViewFromURL.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI

struct ImageCardViewFromURL: View {
    @ObservedObject var image: API<UIImage>
    
    init(url: String) {
        let formattedURL = MovieListViewModel.formatURL(url: url)
//        let request = URLRequest(url: URL(string: formattedURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
//        URLCache.shared.removeCachedResponse(for: request)
        
        self.image = API(url: URL(string: formattedURL)!, transform: {
            UIImage(data: $0)
        })
        self.image.load(fromCache: true)
        
    }
    var body: some View {
        
        Group {
            if image.value != nil {
                Image(uiImage: image.value!)
                    .resizable()
                
            } else {
                Image(systemName: "play.slash")
                    .resizable()
                    
                
            }
        }
    }
}

//struct ImageCardViewFromURL_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCardViewFromURL()
//    }
//}

//
//  API.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import Foundation

final class API<A>: ObservableObject {
    @Published var result: Result<A,Error>? = nil
    
    var value: A? {
        try? result?.get()
    }
    
    let url: URL
    let transform: (Data) -> A?
    
    init(url: URL, transform: @escaping (Data) -> A? ) {
        self.url = url
        self.transform = transform
    }
    
    func load(fromCache: Bool = true) {
        
//        print("url", url)
        
        let cache = URLCache.shared
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        
        if fromCache, let data = cache.cachedResponse(for: request)?.data {
            let v = self.transform(data)
            do {
                guard v != nil else{
                    throw CacheLoadingError()
                }
                self.result = .success(v!)
            } catch {
                print("error getting from cache now trying from remote")
                self.load(fromCache: false)
            }
//            guard self.result = .success(v!) else {
//                self.load(fromCache: false)
//            }
            
        } else {
        
            URLSession.shared.dataTask(with: url) { (data, response, _) in
                if let data = data, let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        if let v = self.transform(data) {
                            self.result = .success(v)
                        } else {
                            self.result = .failure(PhotoLoadingError())
                        }
                    }
                }
               
            }.resume()
            
        }
    }
    
    
}



struct PhotoLoadingError: Error {}
struct CacheLoadingError: Error {}

//
//  Landing.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI

struct Landing: View {
    @State var buckets: [Bucket]
    
    init() {
        self.buckets =  [
            Bucket(name: "watchInProgress", title: "Continue Watching", showMore: false),
            Bucket(name: "recommended", title: "Recommended Movies", showMore: false),
            Bucket(name: "binge-worthy", title: "Binge-worthy TV", showMore: true),
            Bucket(name: "watchInProgress", title: "Drama TV", showMore: false),
            Bucket(name: "recommended", title: "TV shows we think you'll like", showMore: false),
            Bucket(name: "binge-worthy", title: "Watch it again", showMore: true),
            Bucket(name: "binge-worthy", title: "Coming soon", showMore: true),
            Bucket(name: "watchInProgress", title: "Recently added movies", showMore: false),
            Bucket(name: "recommended", title: "Sports TV and movies", showMore: false),
            Bucket(name: "binge-worthy", title: "Movies in English", showMore: true),
            Bucket(name: "binge-worthy", title: "Amazon Original series", showMore: true),
            Bucket(name: "binge-worthy", title: "Amazon Original movies", showMore: true)
        ]
    }
    
    var body: some View {
        VStack {
            ForEach(0..<buckets.count) { i in
                BucketView(bucket: buckets[i])
            }
            
        }
    }
}





struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        Landing()
    }
}

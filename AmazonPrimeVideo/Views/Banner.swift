//
//  Banner.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI

struct Banner: View {
    
    var bannerTitleList: [MovieList] = []
    
    
    init(bannerTitles: [MovieList]) {
        self.bannerTitleList = bannerTitles
    }
    
    var body: some View {
        Carousel(bannerTitleList: self.bannerTitleList)
    }
    
    
    
}

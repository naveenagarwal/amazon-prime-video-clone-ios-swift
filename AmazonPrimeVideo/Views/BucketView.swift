//
//  BucketView.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 03/08/21.
//

import SwiftUI


struct BucketView: View {
    @State var bucket: Bucket
    
    @State var pageNumber = 0
    
    @State var objects: [MovieList] = []
    
    let thumbnailWidth = 150
    let thumbnailHeight = 100
    let progressBarHeight = 5
    
    func loadMore() {
        if self.objects.count % 5 != 0 {
            // no need to load more items - solve the api call where max items are divisible by 5
            return
        }
        let limit = pageNumber*5 + 5
        let url = MovieListViewModel.fetchMovieList(subPath: "movielists", bucketName: bucket.name, limit: limit)
        
        @ObservedObject var content = API(url: URL(string: url)!, transform: {
            self.objects = try! JSONDecoder().decode([MovieList].self, from: $0)
        })
        
        content.load()
    }
    
    func getPercentageWidth(percentage: Int) -> Double {
        return Double((self.thumbnailWidth * percentage) / 100)
    }
    
    func getPercentgeBarXOffset(percentage: Int) -> Double {
        return Double((self.thumbnailWidth - Int(self.getPercentageWidth(percentage: percentage))) / 2)
    }
    
    func getRemainingPercentageWidth(percentage: Int) -> Double {
        return Double(self.thumbnailWidth) - self.getPercentageWidth(percentage: percentage)
    }
    
    func getRemainingPercentageBarXOffset(percentage: Int) -> Double {
        return Double((self.thumbnailWidth - Int(self.getRemainingPercentageWidth(percentage: percentage))) / 2)
    }
    
    
    init(bucket: Bucket) {
        self.bucket = bucket
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(bucket.title)
                .font(.title3)
                .foregroundColor(.white)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                        
                    if self.objects.count > 0 {
                        ForEach(0..<self.objects.count, id: \.self) { i in
                            let movieList =  self.objects[i]
                            NavigationLink(destination: VideoDetailView(video: movieList)) {
                                ZStack {
                                    ImageCardViewFromURL(url: movieList.thumbnailURL)
                                        .frame(width: CGFloat(self.thumbnailWidth), height: CGFloat(self.thumbnailHeight))
                                        .cornerRadius(3.0)
                                        .onAppear {
                                            if i == self.objects.count - 1 {
                                                self.pageNumber += 1
                                                self.loadMore()
                                            }
                                        }
                                    
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .foregroundColor(Color.blue)
                                            .frame(width: CGFloat(self.getPercentageWidth(percentage: movieList.watchedPercentage)), height: CGFloat(self.progressBarHeight))
                                            
                                        Rectangle()
                                            .foregroundColor(Color(#colorLiteral(red: 0.0987310335, green: 0.06857065111, blue: 0.2877355814, alpha: 1)))
                                            .frame(width: CGFloat(self.getRemainingPercentageWidth(percentage: movieList.watchedPercentage)), height: CGFloat(self.progressBarHeight))
                                    }
                                    .offset(y: CGFloat(self.thumbnailHeight / 2 - self.progressBarHeight + 3))
                                    
                                    
                                        
                                        
                                    Image(systemName: "play.circle")
                                        .resizable()
                                        .frame(width: 32, height: 32, alignment: .leading)
                                        .padding(.vertical)
                                        .foregroundColor(.white)
                                        .offset(x: -50, y: 20)
                                        .opacity(0.6)
                                        
                                }
                                .navigationTitle("")
                            }
                            
                        }
                        
                    } else {
                        ProgressView()
                            .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .onAppear {
                                self.loadMore()
                                self.pageNumber += 1
                            }
                    }
                        
                    
                }
                .frame(height: 100)
            }
            
        }
    }
}

//
//  VideoDetailView.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 03/08/21.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    var movieList: MovieList
    @State var videoDetail: VideoDetail? = VideoDetail.example
    
    @State var showFullDescription = false
    
    @State var showLanguageSheet = false
    
    @State var shouldScrollDisabled = false
    @State var selectedButton = 0
    
    @State var closePlayer: Bool = true
    
    @State var presentVideo: Bool = false
    
    func load(video: MovieList) {
        let url = URL(string: MovieListViewModel.getVideoDetailsURL(video: video))

        @ObservedObject var content = API(url: url!, transform: {
            self.videoDetail = try! JSONDecoder().decode(VideoDetail.self, from: $0)
        })

        content.load()
    }
    
    init(video: MovieList) {
        self.movieList = video
    }
    
    func getRemainingTimeLiftInMinutes() -> Int {
        return Int(self.videoDetail!.runningTimeInMinutes -
                    (self.videoDetail!.runningTimeInMinutes * self.videoDetail!.watchedPercentage) / 100)
    }
    
    func getRunningTime() -> String {
        let hours = self.videoDetail!.runningTimeInMinutes / 60
        let remainderMinutes = self.videoDetail!.runningTimeInMinutes % 60
        return "\(hours) h \(remainderMinutes) min"
        
    }
    
    func languagesAsString() -> String {
        return self.videoDetail!.availableAudioLanguages.joined(separator: ", ")
    }
    
    func subtitlesAsString() -> String {
        return self.videoDetail!.availableSubtitleLangauges.joined(separator: ", ")
    }
    
    func moreDetailsArray() -> [MoreDetailsType] {
        let genericDetails = self.videoDetail!.videoGenericDetails
        
        return [
            MoreDetailsType(title: "Genre", value: genericDetails.genre),
            MoreDetailsType(title: "Director", value: genericDetails.director),
            MoreDetailsType(title: "Starring", value: genericDetails.starring),
            MoreDetailsType(title: "Supporting Actors", value: genericDetails.supportingActors),
            MoreDetailsType(title: "Studio ", value: [genericDetails.studio]),
            MoreDetailsType(title: "Content Advisory", value: genericDetails.contentAdvisory)
        ]
            
    }
    
    var sheetView: some View {
            VStack {
                VStack {
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: 2 * (UIScreen.main.bounds.height / 3))
                .background(Color.black)
                .opacity(0.5)
                .onTapGesture {
                    self.showLanguageSheet = false
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Available Languages")
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                        Text("You can change languages while video is playing")
                            .foregroundColor(.gray)
                    }
                    .padding()


                    VStack(alignment: .leading) {
                        Text("Audio")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text(self.languagesAsString())
                            .foregroundColor(.gray)
                    }
                    .padding()

                    Divider()
                        .background(Color.white)
                        .padding()

                    VStack(alignment: .leading) {
                        Text("Subtitles")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text(self.subtitlesAsString())
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .padding(.bottom, 40)
                }
                
                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 3))
                .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
            }
            .offset(y: -7)
    }
    
    var relatedDetails: some View {
        VStack(alignment: .leading) {
            Text("Cast & Crew")
                .foregroundColor(.white)
                .font(.title2)
                .bold()
            
            Text("Details from IMDb")
                .foregroundColor(.gray)
                .font(.caption2)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<self.videoDetail!.cast.count, id: \.self) { i in
                        let cast = self.videoDetail!.cast[i]
                        NavigationLink(destination: CastDetailsView(cast: cast)) {
                            
                                ZStack {
                                    ImageCardViewFromURL(url: cast.photoURL)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    Text(cast.name)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .lineLimit(2)
                                        .frame(width: 100)
                                        .frame(minHeight: 35)
                                        .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                        .background(Color.black)
                                        .opacity(0.7)
                                        .offset(y: 45)
                                        
                                    
                                }
                                .cornerRadius(5)
                                .navigationTitle("")
                        }
                        
                    }
                }
                  
            }
            
            Spacer()
        }
        .padding()
        
    }
    
    var moreDetails: some View {
        VStack(alignment: .leading) {
            ForEach(self.moreDetailsArray(), id: \.self.title) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .foregroundColor(.white)
                        .font(.subheadline)
                    
                    Text(item.value.joined(separator: ", "))
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .padding(.vertical)
            }
            
            VStack(alignment: .leading) {
                Text("Customer Review")
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                Text(String(self.videoDetail!.videoGenericDetails.customerReview))
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
    
    var OtherDetails: some View {
        VStack() {
            HStack(alignment: .center) {
                Button(action: {
                    self.selectedButton = 0
                }, label: {
                    Text("Related")
                        .foregroundColor(.white)
                        .fontWeight(self.selectedButton == 0 ? .bold : .none)
                        .font(self.selectedButton == 0 ? .title2 : .none)
                })
                .padding()
                
                Spacer()
                
                Button(action: {
                    self.selectedButton = 1
                }, label: {
                    Text("More details")
                        .foregroundColor(.white)
                        .fontWeight(self.selectedButton == 1 ? .bold : .none)
                        .font(self.selectedButton == 1 ? .title2 : .none)
                })
                .padding()
            }
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .frame(height: 5)
                    .offset(x: self.selectedButton == 0 ? -(UIScreen.main.bounds.width / 4) : (UIScreen.main.bounds.width / 4))
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .frame(height: 1)
                    .offset(x: self.selectedButton == 0 ? 32 : -32)
            }
        }
    }
    
    
    
    var body: some View {
        if videoDetail != nil {
            let v = videoDetail!
            ScrollView {
                VStack(alignment: .leading)  {
                    PosterImageView(url: v.posterURL)
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(v.name)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .bold()
                                .foregroundColor(.white)
                            Text("prime")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            Text("Included with Prime")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        }
                        
                        HStack {
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading) {
                                
                                Text("Resume Movie")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                
                                Text("\(self.getRemainingTimeLiftInMinutes()) Minutes Left")
                                    .font(.caption)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .padding(.horizontal)
                            
                            Spacer(minLength: 150)
                            
                        }
                        .padding(.horizontal)
                        .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            self.presentVideo = true
                        }
                        .fullScreenCover(isPresented: $presentVideo, content: {
                            let player = AVPlayer(url: URL(string: "http://localhost:3000/assets/videos/gangs-of-ghosts/1.mp4")!)
                            
                            
                            ZStack {
                                Color.black
                                VideoView(isPresented: $presentVideo, videoPlayer: player)
                                    
//                                    .onDisappear {
//                                        DispatchQueue.main.async {
//                                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                                        }
//
//                                    }
//                                    .onAppear {
//                                        DispatchQueue.main.async {
//                                            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//                                        }
//                                    }
                            }
                            .edgesIgnoringSafeArea(.all)
                            
                            
                                
                        })
                        
                        VStack(alignment: .center) {
                            HStack(alignment: .center) {
                                VStack {
                                    Image(systemName: "gobackward")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 32)
                                    Text("Start Over")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                VStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 32)
                                    Text("Watchlist")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                VStack {
                                    Image(systemName: "icloud.and.arrow.down")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 32)
                                    Text("Download")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            }
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {
                            self.showFullDescription = true
                        }, label: {
                            Text(v.description)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .lineLimit(self.showFullDescription ? .max : 3)
                        })
                        .disabled(showFullDescription)
                        
                        Text(String(format: "IMDb %.1f", v.IMDBRating))
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                        
                        HStack {
                            Text(String(v.releaseYear))
                                .foregroundColor(.gray)
                            
                            Text(self.getRunningTime())
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading) {
                                Text("U/A \(v.UARating)+")
                                    .bold()
                                    .foregroundColor(.gray)
                                    .frame(width: 80)
                                    
                            }
                            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            
                            Image(systemName: "text.bubble")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 18, height: 18)
                            
                        }
                            .padding(.top, 5)
                        
                        Button(action: {
                                self.showLanguageSheet = true
                            }, label: {
                                HStack(spacing: 0) {
                                    Text("Languages: Audio (\(v.availableAudioLanguages.count)), Subtitles (\(v.availableSubtitleLangauges.count)) ")
                                        .foregroundColor(.gray)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                            })
                        .fullScreenCover(isPresented: self.$showLanguageSheet, content: {
                            sheetView
                                .clearModalBackground()
                        })
                        
                        OtherDetails
                        
                        if self.selectedButton == 0 {
                            relatedDetails
                        }
                        
                        if self.selectedButton == 1 {
                            moreDetails
                        }
                        
                        
                        
                        
                        
                    }
                    .padding()
                        
                    Spacer()
                }
                
            }
            .disabled(shouldScrollDisabled)
            .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
            
        } else {
            ProgressView()
                .onAppear {
                    self.load(video: movieList)
                }
        }
        
    }
}

struct PosterImageView :View {
    
    @ObservedObject var image: API<UIImage>
    
    init(url: String) {
        self.image = API(url: URL(string: url)!, transform: {
            UIImage(data: $0)
        })
        self.image.load()
        
    }
    var body: some View {
        
        Group {
            if image.value != nil {
                Image(uiImage: image.value!)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    
                
            }
        }
    }
}


struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(video: MovieList.example)
    }
}


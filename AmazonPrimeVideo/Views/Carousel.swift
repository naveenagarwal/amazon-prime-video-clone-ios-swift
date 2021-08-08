//
//  Carousel2View.swift
//  PlayGround1
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI


struct Carousel: View {
    @State var index = 0
    
    @State var bannerTitleList:[MovieList]
    @State var carouselLocation = 0
    
    
    @GestureState var dragState = DragState.inactive
    
    
    
    var width = UIScreen.main.bounds.width
    
    var itemHeight = CGFloat(200)
    
    func formatURL(url: String) -> String {
        let host: String = "empty-vampirebat-4"
        return url.replacingOccurrences(of: "http://localhost:3000", with: "https://\(host).loca.lt")
    }
    
    struct CardView: View {
        @ObservedObject var image: API<UIImage>
        
        init(url: URL) {
            self.image = API(url: url, transform: {
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
    

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(0..<self.bannerTitleList.count) { i in
                        CardView(url: URL(string: self.bannerTitleList[i].thumbnailURL)!)
                            .frame(minWidth: width, idealWidth: width, maxWidth: width, minHeight: itemHeight, idealHeight: itemHeight, maxHeight: itemHeight, alignment: .center)
                            .offset(x: self.getOffset(i))
                            .scaledToFit()
                        
                    }
                }
                
                .gesture(
                    DragGesture()
                        .updating($dragState) { drag, state, transaction in
                            state = .dragging(translation: drag.translation)
                        }
                        .onEnded(onDragEnded)
                )
                
                // dots on carousel
                HStack {
                    ForEach(0..<self.bannerTitleList.count) { index in
                        Circle()
                            .fill(index == relativeLoc() ? Color.red : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .offset(y: -(itemHeight * 0.1))
                
            }
            .frame(height: itemHeight)
            .frame(maxHeight: itemHeight)
            
            
        }
        
    }
    
    enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }
    
//    func getHeight(_ i: Int) -> CGFloat {
////        return itemHeight
//        if i == relativeLoc() {
//            return itemHeight
//        } else {
//            return itemHeight - 100
//        }
//    }

    func getOpacity(_ i: Int) -> Double {
        if i == relativeLoc()
            || i + 1 == relativeLoc()
            || i - 1 == relativeLoc()
            || i + 2 == relativeLoc()
            || i - 2 == relativeLoc()
            || (i + 1) - self.bannerTitleList.count == relativeLoc()
            || (i - 1) + self.bannerTitleList.count == relativeLoc()
            || (i + 2) - self.bannerTitleList.count == relativeLoc()
            || (i - 2) + self.bannerTitleList.count == relativeLoc()
            {
                return 1
        } else {
            return 0
        }
    }

    func relativeLoc() -> Int {
        return ((self.bannerTitleList.count * 10000) + carouselLocation) % self.bannerTitleList.count
    }
    
    func onDragEnded(drag: DragGesture.Value) {
        
        let dragThreshold: CGFloat = 100
        
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
            carouselLocation -= 1
        } else if drag.predictedEndTranslation.width < -dragThreshold || drag.translation.width < -dragThreshold  {
            carouselLocation += 1
        }
    }
    
    func getOffset(_ i: Int) -> CGFloat {
        var offset:CGFloat
        // this sets up the central offset
        if i == relativeLoc() {
            offset = self.dragState.translation.width
        }
        // these set up the offset +/- 1
        else if i == relativeLoc() + 1 || (relativeLoc() == self.bannerTitleList.count - 1 && i == 0) {
            // set offset +1
            offset = self.dragState.translation.width + width
        }
        else if i == relativeLoc() - 1 || (relativeLoc() == 0 && i == self.bannerTitleList.count - 1) {
            // set offset -1
            offset = self.dragState.translation.width - width
        }
        // these set up the offset +/- 2
        else if i == relativeLoc() + 2
                    || (relativeLoc() == self.bannerTitleList.count - 1 && i == 1)
                    || (relativeLoc() == self.bannerTitleList.count - 2 && i == 0) {
            // set offset +2
            offset = self.dragState.translation.width + 2*width
        }
        else if i == relativeLoc() - 2
                    || (relativeLoc() == 1 && i == self.bannerTitleList.count - 1)
                    || (relativeLoc() == 0 && i == self.bannerTitleList.count - 2) {
            // set offset -2
            offset = self.dragState.translation.width - 2*width
        
        }
        // these set up the offset +/- 3
        else if i == relativeLoc() + 3
                    || (relativeLoc() == self.bannerTitleList.count - 1 && i == 2)
                    || (relativeLoc() == self.bannerTitleList.count - 2 && i == 1)
                    || (relativeLoc() == self.bannerTitleList.count - 3 && i == 0) {
            // set offset +3
            offset = self.dragState.translation.width + 3*width
        }
        else if i == relativeLoc() - 3
                    || (relativeLoc() == 2 && i == self.bannerTitleList.count - 1)
                    || (relativeLoc() == 1 && i == self.bannerTitleList.count - 2)
                    || (relativeLoc() == 0 && i == self.bannerTitleList.count - 3) {
            // set offset -3
            offset = self.dragState.translation.width - 3*width
        }
        
        else {
            offset = 10000
        }

        return offset
        
    }
}

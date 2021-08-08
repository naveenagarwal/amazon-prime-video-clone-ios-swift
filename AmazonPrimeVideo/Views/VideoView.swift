//
//  VideoView.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 04/08/21.
//

import SwiftUI
import AVKit

//struct Abc: UIViewControllerRepresentable {
//
//    var videoPlayer: AVPlayer
//
//    init(videoPlayer: AVPlayer) {
//        self.videoPlayer = videoPlayer
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//    }
//
//    func makeUIViewController(context: Context) -> UIPageViewController {
//        let pageViewContoller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
//
//        pageViewContoller.modalPresentationStyle = .fullScreen
//
//
//        return pageViewContoller
//    }
//
//    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
//        let v = UIHostingController( rootView: Video())
//        v.modalPresentationStyle = .fullScreen
//        uiViewController.modalPresentationStyle = .fullScreen
////        uiViewController.preferredInterfaceOrientationForPresentation = .landscapeLeft
//        uiViewController.setViewControllers([v], direction: .forward, animated: true)
//    }
//
//    typealias UIViewControllerType = UIPageViewController
//
//
//}
//
//class MyCustomViewController: UIViewController {
//  override public var shouldAutorotate: Bool {
//    return false
//  }
//  override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//    return .landscapeRight
//  }
//  override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//    return .landscapeRight
//  }
//}
//
//func setupLandscapeView() -> UIViewController {
//  let viewController = MyCustomViewController()
//  viewController.modalPresentationStyle = .fullScreen
//  return viewController
//}
//
//struct Video: View {
//    let p = AVPlayer(url: URL(string: "http://localhost:3000/assets/videos/gangs-of-ghosts/1.mp4")!)
//    var body: some View {
//        VideoPlayer(player: p)
////        Text("Heelo")
//    }
//}

struct VideoView: View {
    @Binding var isPresented: Bool
    
    @State var videoPlayer: AVPlayer

    var body: some View {
        VideoPlayer(player: self.videoPlayer)
//            .rotationEffect(.degrees(90))
            

//        ZStack {
//            VideoPlayer(player: self.videoPlayer)
//            VStack {
//                Button(action: {
//                    print("Closing Player")
//                    videoPlayer.pause()
//                    self.isPresented = false
//                }, label: {
//                    Text("x")
//                        .font(.title)
//                        .foregroundColor(.gray)
//                })
//                Spacer()
//            }

//        }
    }
}

let player1 = AVPlayer(url: URL(string: "http://localhost:3000/assets/videos/gangs-of-ghosts/1.mp4")!)

struct VideoView_Previews: PreviewProvider {

    static var previews: some View {
        VideoView(isPresented: .constant(true), videoPlayer: player1)
    }
}

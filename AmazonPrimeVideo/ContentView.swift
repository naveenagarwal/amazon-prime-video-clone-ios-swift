//
//  ContentView.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI

struct TestView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
                Button(action: {
                    self.isPresented = true
                }, label: {
                    Text("Click to show full screen")
            })
        }
        .onAppear {
            
        }
    }
}

//struct TestView2: View {
//    @State var showVideo: Bool = true
//
//    var body: some View {
//        VStack {
//            VideoView(showVideo: $showVideo)
//        }
//        .onAppear {
//            print("Test View 2")
//            self.showVideo = true
//        }
//    }
//}

struct ContentView: View {
    @State var selection = "Home"
    @State var isPresented = false
    @State var showVideo = true
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
    }
    var body: some View {
//        VideoView()
        
//        TabView {
//
//
//            TestView(isPresented: $isPresented)
//                .fullScreenCover(isPresented: $isPresented, content: {
//                    ZStack {
//                        Color.blue
//
//                        Button(action: {
//
//                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                            self.isPresented = false
//
//
//                        }, label: {
//
//                            Image(systemName: "house")
//                                .resizable()
//                                .foregroundColor(.pink)
//                                .frame(width: 300, height: 300, alignment: .center)
//                        })
//
//                    }
//                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                    .onAppear {
//                        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//                    }
//
//                })
//                .tabItem { Text("Click me") }
//
//            VideoView()
//                .tabItem { Text("Video Player") }
//        }
        ZStack {
            TabView(selection: $selection) {
                Home()
                    .tabItem {
                        Image(systemName: "house")
                            .resizable()
                        Text("Home")

                    }

                    .tag("Home")

                Search()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                        Text("Find")

                    }
                    .tag("Search")

                Downloads()
                    .tabItem {
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                        Text("Find")

                    }
                    .tag("Downloads")

                MyStuff()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                        Text("Find")

                    }
                    .tag("MyStuff")

            }
        }
        .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

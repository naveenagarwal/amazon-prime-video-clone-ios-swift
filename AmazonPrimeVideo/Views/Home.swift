//
//  Home.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI

struct ButtonView: View {
    @Binding var selecedTopTabIndex: Int
    let index: Int
    let name: String
    
    var body: some View {
        Button(action: {
            self.selecedTopTabIndex = index
        }, label: {
            VStack {
                Text(name)
                    .font(.caption)
                    .bold()
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .foregroundColor(self.selecedTopTabIndex == index ? .white : .gray)
                Rectangle()
                    .frame(height: 5)
                    .offset(y: -5)
                    .padding(.horizontal)
                    .foregroundColor(self.selecedTopTabIndex == index ? .white : .clear)
                
                    
            }
            .frame(width: UIScreen.main.bounds.width / 4)
            .offset(y: -10)
        })
    }
}

struct Home: View {
    @State var selecedTopTabIndex = 0
    
    var movieListViewModel = MovieListViewModel()
    let url = MovieListViewModel.fetchMovieList(subPath: "bannertitles")
    @ObservedObject var bannerTitlesAPI:API<[MovieList]>
    
    init() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
        
        bannerTitlesAPI = API(url: URL(string: url)!, transform: {
            try! JSONDecoder().decode([MovieList].self, from: $0)
        })
        
        bannerTitlesAPI.load()
        
    }
    
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    if (bannerTitlesAPI.value ?? nil) != nil {
                        Banner(bannerTitles: bannerTitlesAPI.value!)
                    }
                    
                    if self.selecedTopTabIndex == 0 {
                        Landing()
                    }
                    
                    Spacer()
                }
            }
            .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    
                    VStack {
                        Image("amazon-logo")
                            .resizable()
                            .frame(minWidth: 50, minHeight: 35)
                            .frame(maxWidth: 50, maxHeight: 35)
                        HStack {
                            ButtonView(selecedTopTabIndex: $selecedTopTabIndex, index: 0, name: "Home")
                            ButtonView(selecedTopTabIndex: $selecedTopTabIndex, index: 1, name: "TV Shows")
                            ButtonView(selecedTopTabIndex: $selecedTopTabIndex, index: 2, name: "Movies")
                            ButtonView(selecedTopTabIndex: $selecedTopTabIndex, index: 3, name: "Kids")
                        }
                    }
                }
            }
        } // end navigation view
            .navigationViewStyle(StackNavigationViewStyle())
        
        

        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

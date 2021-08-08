//
//  SwiftUIView.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 04/08/21.
//

import SwiftUI

struct CastDetailsView: View {
    
    @State var cast: MovieCastMember
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                VStack(alignment: .leading) {
                    Text("From: IMDB")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    
                }
                .padding()
                Spacer()
                
            }
            HStack(alignment: .top, spacing: 8) {
                ImageCardViewFromURL(url: cast.photoURL)
                    .frame(width: 100, height: 150)
                
                Text(cast.about)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal, 4)
            

            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Trivia")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(cast.trivia)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                }
                .padding(.horizontal, 4)
               Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 0.05417007953, green: 0.105948098, blue: 0.1652356982, alpha: 1)))
            .cornerRadius(8)
            .padding(.horizontal, 4)

            
        }
        .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
        
    }
}

struct CastDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CastDetailsView(cast: MovieCastMember.example)
    }
}

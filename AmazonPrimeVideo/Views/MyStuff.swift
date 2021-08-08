//
//  MyStuff.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 31/07/21.
//

import SwiftUI

struct MyStuff: View {
    var body: some View {
        ScrollView {
            HStack {
                Text("Hello, my stuff")
                Spacer()
            }
            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
    }
}

struct MyStuff_Previews: PreviewProvider {
    static var previews: some View {
        MyStuff()
    }
}

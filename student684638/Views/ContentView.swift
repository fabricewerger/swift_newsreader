//
//  ContentView.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            NewsListView(feedId: 0)
                .navigationTitle(Text("Het nieuws"))
                .navigationBarItems(
                    leading:
                        Button(action: {
                            //self.refresh.toggle()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        },
                    trailing:
                        NavigationLink(destination: LoginView()) {
                            Image(systemName: "person.fill")
                        }
                )
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

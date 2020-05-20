//
//  ContentView.swift
//  MushroomPredictor
//
//  The ContentView holds the logic of what views to show
//  and when to show them.
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var signInSuccess: Bool
    
    var body: some View {
        Group {
            
            // If the user was able to sign in successfully, show the
            // tab view that holds the three main views
            if self.signInSuccess {
                TabView {
                    VStack {
                        PredictorView()
                    }
                    .padding(.bottom, 10)
                    .tabItem { Text("Predict") }.tag(1)
                    
                    VStack {
                       StatisticsView()
                    }.tabItem { Text("Statistics") }.tag(2)
                    
                    VStack {
                        TaggedDataView()
                    }.tabItem { Text("Tagged Data") }.tag(3)
                }
            // Stay on the LoginView by default
            } else {
                LoginView(callback: { result in
                    self.signInSuccess = result
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(signInSuccess: false)
    }
}

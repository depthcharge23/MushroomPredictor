//
//  ContentView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                PredictorView()
            }
            .padding(.bottom, 10)
            .tabItem { Text("Predict") }.tag(1)
            
            VStack {
               StatisticsView()
            }.tabItem { Text("Statistics") }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

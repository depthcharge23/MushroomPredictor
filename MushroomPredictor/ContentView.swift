//
//  ContentView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var confidence: Double
    @State var prediction: String
    
    var body: some View {
        PredictorView(confidence: confidence, prediction: prediction)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(confidence: 0.0, prediction: "")
    }
}

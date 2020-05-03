//
//  ContentView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private var predictor = Predictor(prediction: "", confidence: 0.0)
    
    var body: some View {
        PredictorView(predictor: self.predictor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

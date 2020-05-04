//
//  MushroomResultView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/3/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct MushroomResultView: View {
    var prediction: String
    var confidence: Double
    
    var body: some View {
        VStack{
            Text(self.prediction)
            Text(self.confidence.description)
        }
    }
}

struct MushroomResultView_Previews: PreviewProvider {
    static var previews: some View {
        MushroomResultView(prediction: "Hello World", confidence: 0.0)
    }
}

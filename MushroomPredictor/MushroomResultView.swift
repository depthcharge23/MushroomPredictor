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
            VStack {
                
                if self.prediction == "Poisonous" || self.prediction == "Edible" {
                    Text("This mushroom is " + self.prediction)
                        .font(.headline)
                    
                    if self.prediction == "Poisonous" {
                        Text("Do not eat!")
                            .font(.title)
                            .foregroundColor(Color.red)
                    }
                    
                    if self.prediction == "Edible" {
                        Text("Go ahead and enjoy!")
                            .font(.title)
                            .foregroundColor(Color.green)
                    }
                } else {
                    Text("An error occurred...")
                        .font(.title)
                        .foregroundColor(Color.red)
                }
            }
            .padding()
            
            if self.confidence > -1.0 {
                VStack {
                    Text("The confidence of the prediction is...")
                        .font(.headline)
                    
                    if self.confidence >= 90.0 {
                        Text(self.confidence.description + "%")
                            .font(.title)
                            .foregroundColor(Color.green)
                    } else if self.confidence >= 75.0 {
                        Text(self.confidence.description + "%")
                        .font(.title)
                        .foregroundColor(Color.yellow)
                    } else {
                        Text(self.confidence.description + "%")
                        .font(.title)
                        .foregroundColor(Color.red)
                    }
                }
                .padding()
            }
        }
    }
}

struct MushroomResultView_Previews: PreviewProvider {
    static var previews: some View {
        MushroomResultView(prediction: "Edible", confidence: 100.0)
    }
}

//
//  MushroomResultView.swift
//  MushroomPredictor
//
//  This view was created to show the results of the prediction
//  made by the Azure API.
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
                // Validate data
                if self.prediction == "Poisonous" || self.prediction == "Edible" {
                    Text("This mushroom is " + self.prediction)
                        .font(.headline)
                    
                    // If the prediction is Poisonous show do not
                    // eat message
                    if self.prediction == "Poisonous" {
                        Text("Do not eat!")
                            .font(.title)
                            .foregroundColor(Color.red)
                    }
                    
                    // If the prediction is Edible show the eat
                    // message
                    if self.prediction == "Edible" {
                        Text("Go ahead and enjoy!")
                            .font(.title)
                            .foregroundColor(Color.green)
                    }
                
                // If the prediction is neither poisonous or edible
                // show an error message
                } else {
                    Text("An error occurred...")
                        .font(.title)
                        .foregroundColor(Color.red)
                }
            }
            .padding()
            
            // Validate data
            if self.confidence > -1.0 {
                VStack {
                    Text("The confidence of the prediction is...")
                        .font(.headline)
                    
                    // If the confidence is over 90% show a green
                    // message
                    if self.confidence >= 90.0 {
                        Text(self.confidence.description + "%")
                            .font(.title)
                            .foregroundColor(Color.green)
                    // If the confidence is over 75% show a yellow
                    // message
                    } else if self.confidence >= 75.0 {
                        Text(self.confidence.description + "%")
                        .font(.title)
                        .foregroundColor(Color.yellow)
                    // Else show a red message
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

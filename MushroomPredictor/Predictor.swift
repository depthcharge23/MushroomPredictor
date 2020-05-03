//
//  Predictor.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import NetworkExtension

class Predictor {
    
    private var prediction: String
    private var confidence: Double
    
    init(prediction: String, confidence: Double) {
        self.prediction = prediction
        self.confidence = confidence
    }
    
    func getPrediction() -> String {
        return self.prediction
    }
    
    func getConfidence() -> Double {
        return self.confidence
    }
    
    func postJson() {
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/predict-mushroom")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["data": [3,4,1,1,8,3,1,2,1,1,4,4,4,8,8,1,3,2,6,1,4,5]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

            if let responseJSON = responseJSON as? [String: Any] {
                if let prediction = responseJSON["prediction"] as? Int {
                    if prediction == 1 {
                        self.prediction = "Poisonous"
                    } else if prediction == 2 {
                        self.prediction = "Edible"
                    } else {
                        self.prediction = "Unknown"
                    }
                } else {
                    self.prediction = "Unkown"
                }
                
                if let confidence = responseJSON["confidence"] as? Int {
                    self.confidence = Double(confidence) * 100.0
                } else {
                    self.confidence = 0.0
                }
            }
        }
        
        task.resume()
    }
}

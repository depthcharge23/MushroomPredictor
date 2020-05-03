//
//  Predictor.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import NetworkExtension

class Predictor {
    
    private func constructRtn(responseJSON: [String: Any]) -> [String: Any] {
        var rtn: [String: Any] = [:]
        
        if let prediction = responseJSON["prediction"] as? Int {
            if prediction == 1 {
                rtn["prediction"] = "Poisonous"
            } else if prediction == 2 {
                rtn["prediction"] = "Edible"
            } else {
                rtn["prediction"] = "Unknown"
            }
        } else {
            rtn["prediction"] = "Unkown"
        }
        
        if let confidence = responseJSON["confidence"] as? Int {
            rtn["confidence"] = Double(confidence) * 100.0
        } else {
            rtn["confidence"] = 0.0
        }
        
        return rtn
    }
    
    func postJson(capShape: Int, capSurface: Int, capColor: Int, bruises: Int, odor: Int, gillAttachment: Int,
                  gillSpacing: Int, gillSize: Int, gillColor: Int, stalkShape: Int, stalkRoot: Int,
                  stalkSurfaceAboveRing: Int, stalkSurfaceBelowRing: Int, stalkColorAboveRing: Int,
                  stalkColorBelowRing: Int, veilType: Int, veilColor: Int, ringNumber: Int, ringType: Int,
                  sporePrintColor: Int, population: Int, habitat: Int) -> [String: Any] {
        
        var rtn: [String: Any] = [:]
        
        let json: [String: Any] = ["data": [capShape, capSurface, capColor, bruises, odor, gillAttachment,
                                            gillSpacing, gillSize, gillColor, stalkShape, stalkRoot,
                                            stalkSurfaceAboveRing, stalkSurfaceBelowRing, stalkColorAboveRing,
                                            stalkColorBelowRing, veilType, veilColor, ringNumber, ringType,
                                            sporePrintColor, population, habitat]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/predict-mushroom")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

            if let responseJSON = responseJSON as? [String: Any] {
                rtn = self.constructRtn(responseJSON: responseJSON)
            }
        }
        
        task.resume()
        
        return rtn
    }
}

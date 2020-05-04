//
//  Predictor.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import NetworkExtension

class Predictor {
    
    func postJson(capShape: Int, capSurface: Int, capColor: Int, bruises: Int, odor: Int, gillAttachment: Int,
                  gillSpacing: Int, gillSize: Int, gillColor: Int, stalkShape: Int, stalkRoot: Int,
                  stalkSurfaceAboveRing: Int, stalkSurfaceBelowRing: Int, stalkColorAboveRing: Int,
                  stalkColorBelowRing: Int, veilType: Int, veilColor: Int, ringNumber: Int, ringType: Int,
                  sporePrintColor: Int, population: Int, habitat: Int, completionHandler: @escaping (_ rtn: [String: Any]) -> ()) {
        
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
                print(responseJSON["prediction"] ?? "Error")
                print(responseJSON["confidence"] ?? "Error")
                completionHandler(responseJSON)
            }
        }
        
        task.resume()
    }
}

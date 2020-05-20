//
//  Predictor.swift
//  MushroomPredictor
//
//  The Predictor class is the class that handles the POST HTTP request to the API hosted in Azure that makes the mushroom
//  classification prediction.
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import NetworkExtension

class Predictor {
    
    // This function will make the POST request to classify the mushroom
    func postJson(capShape: Int, capSurface: Int, capColor: Int, bruises: Int, odor: Int, gillAttachment: Int,
                  gillSpacing: Int, gillSize: Int, gillColor: Int, stalkShape: Int, stalkRoot: Int,
                  stalkSurfaceAboveRing: Int, stalkSurfaceBelowRing: Int, stalkColorAboveRing: Int,
                  stalkColorBelowRing: Int, veilType: Int, veilColor: Int, ringNumber: Int, ringType: Int,
                  sporePrintColor: Int, population: Int, habitat: Int, completionHandler: @escaping (_ rtn: [String: Any]) -> ()) {
        
        // Construct a Swift dictionary of the mushroom data inputed by the user
        let json: [String: Any] = ["data": [capShape, capSurface, capColor, bruises, odor, gillAttachment,
                                            gillSpacing, gillSize, gillColor, stalkShape, stalkRoot,
                                            stalkSurfaceAboveRing, stalkSurfaceBelowRing, stalkColorAboveRing,
                                            stalkColorBelowRing, veilType, veilColor, ringNumber, ringType,
                                            sporePrintColor, population, habitat]]
        
        // Convert the Swift dictionary to a JSON object
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // Create a URL object
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/predict-mushroom")!
        
        // Create a request object
        var request = URLRequest(url: url)
        
        // Set the request object properties
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Send the HTTP request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Make sure a value is returned
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            // Convert the JSON object into a Swift dictionary
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            // If the Swift dictionary is of the type [String: Any] run the completionHandler()
            // with the JSON object
            // Else send a dictionary with an error message to the completionHandler()
            if let responseJSON = responseJSON as? [String: Any] {
                completionHandler(responseJSON)
            } else {
                completionHandler(["error": "An internal error occurred..."])
            }
        }
        
        task.resume()
    }
}

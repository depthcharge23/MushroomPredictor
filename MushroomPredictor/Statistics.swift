//
//  Statistics.swift
//  MushroomPredictor
//
//  This class was created to send the POST requests to the API hosted in Microsoft Azure.
//  This class can run the function to get pie and bar graphs, or run the function to
//  fetch a heat map.
//
//  Created by Aaron Mathews on 5/6/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import Foundation
import NetworkExtension

class Statistics {
    
    // The method to retrieve bar or pie graphs
    func postJson(graphType: String, prop: String, completionHandler: @escaping (_ rtn: [String: Any]) -> ()) {
        
        // Create Swift dictionary
        let json: [String: Any] = ["graphType": graphType, "prop": prop]
        
        // Turn the Swift dictionary into a JSON object
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // Create a URL object
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/get-graph")!
        
        // Create a request object
        var request = URLRequest(url: url)
        
        // Set the request properties
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Make sure data was returned
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            // Convert the JSON object into a Swift dictionary
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

            // If the Swift dictionary is of type [String: Any] fire the completionHandler()
            // with the converted JSON object.
            // Else send a dictionary with an error message
            if let responseJSON = responseJSON as? [String: Any] {
                completionHandler(responseJSON)
            } else {
                completionHandler(["error": "An internal error occurred..."])
            }
        }
        
        task.resume()
    }
    
    // The method to retrieve the heat map from the Azure API
    func postJsonHeatMap(prop: String, completionHandler: @escaping (_ rtn: [String: Any]) -> ()) {
        
        // Create a Swift dictionary
        let json: [String: Any] = ["prop": prop]
        
        // Convert the Swift dictionary into a JSON object
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // Create a URL object
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/heat-map-data")!
        
        // Create a request object
        var request = URLRequest(url: url)
        
        // Set the properties of the request object
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Make sure data is returned
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            // Convert the returned JSON into a Swift dictionary
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

            // If the Swift dictionary is of type [String: Any] fire the completionHandler()
            // with the converted JSON object.
            // Else send a dictionary with an error message
            if let responseJSON = responseJSON as? [String: Any] {
                completionHandler(responseJSON)
            } else {
                completionHandler(["error": "An internal error occurred..."])
            }
        }
        
        task.resume()
    }
}

//
//  Statistics.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/6/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import Foundation
import NetworkExtension

class Statistics {
    func postJson(graphType: String, prop: String, completionHandler: @escaping (_ rtn: [String: Any]) -> ()) {
        let json: [String: Any] = ["graphType": graphType, "prop": prop]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/get-graph")!
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
                completionHandler(responseJSON)
            } else {
                completionHandler(["error": "An internal error occurred..."])
            }
        }
        
        task.resume()
    }
    
    func postJsonHeatMap(prop: String, completionHandler: @escaping (_ rtn: [String: Any]) -> ()) {
        let json: [String: Any] = ["prop": prop]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "https://mushroom-predictor.azurewebsites.net/heat-map-data")!
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
                completionHandler(responseJSON)
            } else {
                completionHandler(["error": "An internal error occurred..."])
            }
        }
        
        task.resume()
    }
}

//
//  TaggedDataView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/17/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

func postJSON(prop: String, completionHandler: @escaping ([String: Any]) -> ()) {
    let json = [
        "prop": prop
    ]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    let url = URL(string: "https://mushroom-predictor.azurewebsites.net/map-data")!
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

struct TaggedDataView: View {
    var props: [String] = ["Cap-Shape", "Cap-Surface", "Cap-Color", "Gill-Attachment", "Gill-Spacing", "Gill-Size", "Gill-Color", "Stalk-Shape", "Stalk-Root", "Stalk-Surface-Above-Ring", "Stalk-Surface-Below-Ring", "Stalk-Color-Above-Ring", "Stalk-Color-Below-Ring", "Veil-Type", "Veil-Color", "Ring-Number", "Ring-Type", "Bruises", "Odor", "Spore-Print-Color", "Population", "Habitat"]
    
    @State var vals: [[String]] = []
    
    @State var selectedProp = "Cap-Shape"
    @State var isLoading = false
    @State var errorMsg = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("Mushroom Data Tags")
                    .font(.title)
                
                HStack {
                    DropDownMenu(label: "Property", menuVals: self.props, alignment: .leading, callback: { selected in self.selectedProp = selected }, selected: self.selectedProp)
                        .padding(10)

                    Button(action: {
                        self.isLoading = true
                        self.vals = []

                        postJSON(prop: self.selectedProp.lowercased()) { result in
                            for (key, value) in result {
                                if key == "error" {
                                    self.errorMsg = value as! String
                                } else {
                                    var arr = [key]

                                    if let dataValue = value as? [String] {
                                        for val in dataValue {
                                            arr.append(val)
                                        }
                                    }

                                    self.vals.append(arr)
                                }
                            }

                            self.isLoading = false
                        }
                    }) {
                        Text("Enter")
                            .foregroundColor(Color.green)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }
                } // End of HStack Menu
                
                TaggedDataScrollView(vals: self.vals)
                    .padding()
                    .overlay(
                        ZStack {
                            if self.isLoading {
                                Color.white
                            }

                            ActivityIndicator(isAnimating: self.$isLoading)
                        }
                        .padding()
                    )
                
                Spacer()
            } // End of Parent VStack
            .padding()
            
            if self.errorMsg != "" {
                VStack {
                    Text(self.errorMsg)
                        .padding()
                    
                    Button(action: {
                        self.errorMsg = ""
                    }) {
                        Text("Close")
                            .foregroundColor(Color.red)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    .padding(.bottom)
                }
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
            }
        }
    }
}

struct TaggedDataView_Previews: PreviewProvider {
    static var previews: some View {
        TaggedDataView()
    }
}

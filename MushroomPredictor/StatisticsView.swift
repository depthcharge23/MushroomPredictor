//
//  StatisticsView.swift
//  MushroomPredictor
//
//  The StatisticsView lets the user interact with the kind of graphs
//  they want to generate, and for which mushroom properties to
//  generate the graphs for.
//
//  This view allows the user to generate pie, bar, and heat map
//  graphs.
//
//  Created by Aaron Mathews on 5/6/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    // The Statistics object is used to send the HTTP requests to
    // the Azure API
    var statistics: Statistics = Statistics()
    
    // The types of graphs the view can generate
    var graphTypes: [String] = ["Pie", "Bar", "Heat Map"]
    
    // A list of the mushroom properties
    var props: [String] = ["Class", "Cap-Shape", "Cap-Surface", "Cap-Color", "Gill-Attachment", "Gill-Spacing", "Gill-Size", "Gill-Color", "Stalk-Shape", "Stalk-Root", "Stalk-Surface-Above-Ring", "Stalk-Surface-Below-Ring", "Stalk-Color-Above-Ring", "Stalk-Color-Below-Ring", "Veil-Type", "Veil-Color", "Ring-Number", "Ring-Type", "Bruises", "Odor", "Spore-Print-Color", "Population", "Habitat"]
    
    @State var image: UIImage = UIImage()
    @State var selectedGraphType: String = "Pie"
    @State var selectedProp: String = "Class"
    @State var isLoading: Bool = false
    @State var errorMsg = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("Mushroom Statistics")
                    .font(.title)
                
                // Menu section
                VStack {
                    HStack {
                        DropDownMenu(label: "Graph Type", menuVals: self.graphTypes, alignment: .leading
                            , callback: { selected in self.selectedGraphType = selected}, selected: self.selectedGraphType)
                            .padding()
                        
                        DropDownMenu(label: "Property", menuVals: self.props, alignment: .leading
                            , callback: { selected in self.selectedProp = selected}, selected: self.selectedProp)
                            .padding()
                    } // End of DropDownMenu HStack
                    
                    Button(action: {
                        self.isLoading = true
                        
                        // If the selected graphType is not a heat
                        // map send one request
                        if self.selectedGraphType != "Heat Map" {
                            self.statistics.postJson(graphType: self.selectedGraphType.lowercased(), prop: self.selectedProp.lowercased()) { result in
                                
                                // Convert the base64 code into an
                                // image
                                if let imageObj = result["image"] as? String {
                                    if let imageData = Data(base64Encoded: imageObj) {
                                        if let uiImage = UIImage(data: imageData) {
                                            self.image = uiImage
                                        }
                                    }
                                }
                                
                                if let error = result["error"] as? String {
                                    self.errorMsg = error
                                }
                                
                                self.isLoading = false
                            }
                        // If the selected graphType is a heat map
                        // send the request for a heat map
                        } else {
                            self.statistics.postJsonHeatMap(prop: self.selectedProp.lowercased()) { result in
                                
                                // Convert the base64 code to an
                                // image
                                if let imageObj = result["image"] as? String {
                                    if let imageData = Data(base64Encoded: imageObj) {
                                        if let uiImage = UIImage(data: imageData) {
                                            self.image = uiImage
                                        }
                                    }
                                }
                                
                                if let error = result["error"] as? String {
                                    self.errorMsg = error
                                }
                                
                                self.isLoading = false
                            }
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
                } // End Search Section VStack
                
                // The graph image
                Image(uiImage: self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .padding(.trailing)
                    .overlay(
                        ZStack {
                            if self.isLoading {
                                Color.white
                            }
                            ActivityIndicator(isAnimating: self.$isLoading)
                        }
                    )
                
                Spacer()
            } // End of Section VStack
            .onAppear {
                // When the view appears load one graph to display
                // to the user
                self.isLoading = true

                self.statistics.postJson(graphType: self.selectedGraphType.lowercased(), prop: self.selectedProp.lowercased()) { result in
                    
                    // Convert the base64 string to an image
                    if let imageObj = result["image"] as? String {
                        if let imageData = Data(base64Encoded: imageObj) {
                            if let uiImage = UIImage(data: imageData) {
                                self.image = uiImage
                            }
                        }
                    }

                    self.isLoading = false
                }
            } // End of VStack
            
            // Show server error message if anything goes wrong
            if self.errorMsg != "" {
                VStack {
                    Text(self.errorMsg)
                        .padding()
                    
                    // Button to close the error message pop up
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
        } // End of ZStack
    } // End of body
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}

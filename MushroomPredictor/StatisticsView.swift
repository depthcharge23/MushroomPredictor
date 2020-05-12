//
//  StatisticsView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/6/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    var statistics: Statistics = Statistics()
    var graphTypes: [String] = ["Pie", "Bar"]
    var props: [String] = ["Cap-Shape", "Cap-Surface", "Cap-Color"]
    
    @State var image: UIImage = UIImage()
    @State var selectedGraphType: String = "Pie"
    @State var selectedProp: String = "Class"
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Text("Mushroom Statistics")
                .font(.title)
            
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
                    
                    self.statistics.postJson(graphType: self.selectedGraphType.lowercased(), prop: self.selectedProp.lowercased()) { result in
                        if let imageObj = result["image"] as? String {
                            if let imageData = Data(base64Encoded: imageObj) {
                                if let uiImage = UIImage(data: imageData) {
                                    self.image = uiImage
                                }
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
            } // End Search Section VStack
            
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
            self.isLoading = true
            
            self.statistics.postJson(graphType: self.selectedGraphType.lowercased(), prop: self.selectedProp.lowercased()) { result in
                if let imageObj = result["image"] as? String {
                    if let imageData = Data(base64Encoded: imageObj) {
                        if let uiImage = UIImage(data: imageData) {
                            self.image = uiImage
                        }
                    }
                }
                
                self.isLoading = false
            }
        }
    } // End of body
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}

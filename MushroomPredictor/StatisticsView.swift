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
    var graphTypes: [String] = ["Basic", "Bar", "Pie"]
    var props: [String] = ["Cap-Shape", "Cap-Surface", "Cap-Color"]
    
    @State var image: UIImage = UIImage()
    @State var selectedGraphType: String = "Basic"
    @State var selectedProp: String = "Cap-Shape"
    
    var body: some View {
        VStack {
            HStack {
                DropDownMenu(label: "Graph Type", menuVals: self.graphTypes, alignment: .leading
                    , callback: { selected in self.selectedGraphType = selected}, selected: self.selectedGraphType)
                    .padding()
                DropDownMenu(label: "Property", menuVals: self.props, alignment: .leading
                    , callback: { selected in self.selectedProp = selected}, selected: self.selectedProp)
                .padding()
            }
            
            VStack {
                Image(uiImage: self.image)
                
                Button(action: {
                    self.statistics.postJson(graphType: self.selectedGraphType.lowercased(), prop: self.selectedProp.lowercased()) { result in
                        if let imageObj = result["image"] as? String {
                            if let imageData = Data(base64Encoded: imageObj) {
                                if let uiImage = UIImage(data: imageData) {
                                    self.image = uiImage
                                }
                            }
                        }
                    }
                }) {
                    Text("Enter")
                }
            } // End Image Button VStack
        } // End Section VStack
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}

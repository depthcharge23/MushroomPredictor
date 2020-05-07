//
//  StatisticsView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/6/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    var statistics = Statistics()
    
    @State var image: UIImage = UIImage()
    
    var body: some View {
        VStack {
            Image(uiImage: self.image)
            
            Button(action: {
                self.statistics.postJson(graphType: "basic") { result in
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
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}

//
//  TaggedDataScrollView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/17/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct TaggedDataScrollView: View {
    var vals: [[String]]
    
    var body: some View {
        VStack {
            if self.vals.count > 0 {
                Text("Tagged Data")
                    .font(.headline)
                    .padding(10)
                
                GeometryReader { geometry in
                    ScrollView {
                        ForEach(self.vals.indices, id: \.self) { i in
                            HStack {
                                ForEach(self.vals[i].indices, id: \.self) { j in
                                    DataTagView(data: self.vals[i][j])
                                }
                            }
                            .padding(.bottom, 5)
                            .padding(.top, 5)
                            .frame(width: geometry.size.width)
                        }
                    }
                    .frame(width: geometry.size.width)
                }
                .frame(height: 100)

                if self.vals.count > 3 {
                    Text("Scroll for more...")
                        .font(.system(size: 10))
                        .foregroundColor(Color.blue)
                }
            }
        } // End of tagged data VStack
    }
}

struct TaggedDataScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TaggedDataScrollView(vals: [["Convex", "Edible", "Poisonous"]])
    }
}

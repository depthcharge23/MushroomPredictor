//
//  TaggedDataScrollView.swift
//  MushroomPredictor
//
//  The TaggedDataScrollView will show the tagged data inside of
//  scroll view so it doesn't take up too much space on screen.
//
//  Created by Aaron Mathews on 5/17/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct TaggedDataScrollView: View {
    var vals: [[String]]
    
    var body: some View {
        VStack {
            // If there are vals create the scroll section
            if self.vals.count > 0 {
                Text("Tagged Data")
                    .font(.headline)
                    .padding(10)
                
                // Scroll section of tagged data
                GeometryReader { geometry in
                    ScrollView {
                        // Double ForEach loop to loop through the
                        // 2D array of self.vals
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

                // If there are more than 3 vals show the scroll
                // for more message
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

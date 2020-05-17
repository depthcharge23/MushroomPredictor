//
//  DataTagView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/17/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct DataTagView: View {
    var data: String
    
    var body: some View {
        Group {
            if self.data == "Edible" {
                Text("E")
                    .padding(5)
                    .font(.system(size: 12))
                    .foregroundColor(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.green, lineWidth: 2)
                    )
            } else if self.data == "Poisonous" {
                Text("P")
                    .padding(5)
                    .font(.system(size: 12))
                    .foregroundColor(Color.red)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.red, lineWidth: 2)
                    )
            } else {
                Text(self.data)
                    .font(.subheadline)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct DataTagView_Previews: PreviewProvider {
    static var previews: some View {
        DataTagView(data: "Poisonous")
    }
}

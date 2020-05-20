//
//  DataTagView.swift
//  MushroomPredictor
//
//  The DataTagView is used to show a property and its tags
//
//  Created by Aaron Mathews on 5/17/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct DataTagView: View {
    var data: String
    
    var body: some View {
        Group {
            // If edible show a green "E"
            // If poisonous show a red "P"
            // If anything else show the text
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

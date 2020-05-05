//
//  Checkbox.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/4/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct RadioButton: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String) -> ()
    
    init (id: String, label: String, size: CGFloat = 10, color: Color = Color.black, textSize: CGFloat = 14, isMarked: Bool = false, callback: @escaping (String) -> ()) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action: {
            self.callback(self.id)
        }) {
            HStack(spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                
                Text(label)
                    .font(Font.system(size: textSize))
            }
            .foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(id: "checkbox", label: "Checkbox", size: 30, color: Color.black, textSize: 14, isMarked: true, callback: {_ in })
    }
}

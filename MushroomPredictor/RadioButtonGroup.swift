//
//  RadioButtonGroup.swift
//  MushroomPredictor
//
//  The RadioButtonGroup view is used to represent a group of radio
//  buttons.
//
//  Created by Aaron Mathews on 5/4/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct RadioButtonGroup: View {
    let callback: (String) -> ()
    let radioBtnVals: [String]
    
    @State var selectedId: String
    
    // Sets the selected value from the radio button group
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
    
    var body: some View {
        VStack {
            // Lives in a scroll view so the radio button group
            // can't get too big
            ScrollView {
                VStack(alignment: .leading) {
                    // Creates the multiple radio buttons
                    ForEach(radioBtnVals, id: \.self) { val in
                        RadioButton(id: val, label: val, isMarked: self.selectedId == val ? true : false, callback: self.radioGroupCallback)
                    }
                }
                .padding(10)
            }
            .frame(height: 100)
            
            // If there are more than 3 radio buttons a
            // message will be displayed telling the user they
            // can scroll for more
            if self.radioBtnVals.count > 3 {
                Text("Scroll for more...")
                    .font(.system(size: 10))
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup(callback: {selected in print("result: \(selected)")}, radioBtnVals: ["Hello world", "Goodbye world"], selectedId: "Hello World")
    }
}

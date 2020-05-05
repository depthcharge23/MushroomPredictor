//
//  RadioButtonGroup.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/4/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct RadioButtonGroup: View {
    let callback: (String) -> ()
    let radioBtnVals: [String]
    
    @State var selectedId: String
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(radioBtnVals, id: \.self) { val in
                RadioButton(id: val, label: val, isMarked: self.selectedId == val ? true : false, callback: self.radioGroupCallback)
            }
        }
    }
}

struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup(callback: {selected in print("result: \(selected)")}, radioBtnVals: ["Hello world", "Goodbye world"], selectedId: "Hello World")
    }
}

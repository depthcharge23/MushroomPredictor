//
//  DropDownMenu.swift
//  MushroomPredictor
//
//  The DropDownMenu view is used to create the drop down menus
//  used throughout the app.
//
//  Created by Aaron Mathews on 5/4/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct DropDownMenu: View {
    var label: String
    var menuVals: [String]
    var alignment: HorizontalAlignment
    var callback: (String) -> ()
    
    @State var expand: Bool = false
    @State var selected: String
    
    var body: some View {
        VStack(alignment: self.alignment) {
            // The menu header controls
            // onTapGesture() toggle the self.expand value
            HStack {
                VStack(alignment: .leading) {
                    Text(self.label)
                        .font(.headline)
                    
                    // Shows the value selected from the radio
                    // button group
                    if selected != "" && !expand {
                        Text(selected)
                            .font(.subheadline)
                    }
                }
                .padding(.trailing)
                
                // The chevron image, up or down
                Image(systemName: self.expand ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                self.expand.toggle()
            }
            
            // On expand show the radio button group
            if self.expand {
                RadioButtonGroup(callback: { selected in
                    self.selected = selected
                    self.callback(selected)
                }, radioBtnVals: self.menuVals, selectedId: selected)
            }
        }
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu(label: "Menu", menuVals: ["Hello world", "Goodbye world"], alignment: .leading, callback: {selected in print("selected: \(selected)")}, selected: "Hello World")
    }
}

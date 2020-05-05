//
//  DropDownMenu.swift
//  MushroomPredictor
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
            HStack {
                VStack(alignment: .leading) {
                    Text(self.label)
                        .font(.headline)
                    if selected != "" && !expand {
                        Text(selected)
                            .font(.subheadline)
                    }
                }
                .padding(.trailing)
                Image(systemName: self.expand ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                self.expand.toggle()
            }
            
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

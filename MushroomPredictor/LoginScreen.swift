//
//  LoginScreen.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 4/29/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
    @State var password: String = ""
    @State var username: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Username")
            TextField("Username", text: $username)
                .padding()
                .border(Color.gray, width: 1)
            
            Text("Password")
            SecureField("Password", text: $password)
                .padding()
                .border(Color.gray, width: 1)
            
            Button(action: {}) {
                Text("Login")
                    .padding()
            }
            .border(Color.blue, width: 1)
        }
        .padding(25)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

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
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Username")
                    .foregroundColor(Color.white)
                
                TextField("Username", text: $username)
                    .padding(10)
                    .border(Color.gray, width: 1)
                    .background(Color.white)
                
                Text("Password")
                    .foregroundColor(Color.white)
                
                SecureField("Password", text: $password)
                    .padding(10)
                    .border(Color.gray, width: 1)
                    .background(Color.white)
                
                Button(action: {}) {
                    Text("Login")
                        .padding(10)
                        .foregroundColor(Color.black)
                }
                .border(Color.gray, width: 1)
                .background(Color.white)
            }
            .padding(25)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

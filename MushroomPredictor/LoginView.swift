//
//  LoginView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/7/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image("MushroomLogo")
                Text("Mushroom Predictor")
                    .font(.title)
            }
            
            VStack(alignment: .leading) {
                Text("Email")
                    .padding(.leading)
                
                TextField("Email", text: self.$username)
                    .padding(.leading)
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )

                Text("Password")
                    .padding(.leading)
                
                SecureField("Password", text: self.$password)
                    .padding(.leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
            } // End of login control VStack
            .padding()
            
            VStack {
                Button(action: {}) {
                    Text("Submit")
                        .foregroundColor(Color.green)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

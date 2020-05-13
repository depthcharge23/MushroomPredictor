//
//  LoginView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/7/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

func loginUser(username: String, password: String, completionHandler: @escaping ([String: Any]) -> ()) -> () {
    let json = [
        "username": username,
        "password": password
    ]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    let url = URL(string: "https://mushroom-predictor.azurewebsites.net/get-user")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

        if let responseJSON = responseJSON as? [String: Any] {
            completionHandler(responseJSON)
        }
    }
    
    task.resume()
}

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @State var showLoginError = false
    @State var showServerError = false
    @State var isLoading = false
    
    var callback: (Bool) -> ()
    
    func completionHandler(input: [String: Any]) -> () {
        self.isLoading = true
        let status = input["status"] as? String
        
        if status == "valid" {
            self.callback(true)
            self.showLoginError = false
            self.showServerError = false
        } else if status == "invalid" {
            self.callback(false)
            self.showLoginError = true
            self.showServerError = false
        } else {
            self.callback(false)
            self.showLoginError = false
            self.showServerError = true
        }
        
        self.isLoading = false
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image("MushroomLogo")
                Text("Mushroom Predictor")
                    .font(.title)
            } // End of header for login form
            
            VStack(alignment: .leading) {
                if self.showLoginError {
                    Text("Incorrect email or passowrd...")
                        .foregroundColor(Color.red)
                        .padding(.bottom, 5)
                } else if self.showServerError {
                    Text("An error has occurred. Please try again...")
                        .foregroundColor(Color.red)
                        .padding(.bottom, 5)
                }
                
                Text("Email")
                    .padding(.leading)
                
                TextField("Email", text: self.$username)
                    .autocapitalization(.none)
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
            .overlay(
                ZStack {
                    if self.isLoading {
                        Color.white
                    }
                    ActivityIndicator(isAnimating: self.$isLoading)
                }
            )
            
            VStack {
                Button(action: {
                    loginUser(username: self.username, password: self.password, completionHandler: self.completionHandler)
                }) {
                    Text("Sign In")
                        .foregroundColor(Color.green)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
            } // End of login button VStack
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(callback: { _ in
            print("Hello")
        })
    }
}

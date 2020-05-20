//
//  LoginView.swift
//  MushroomPredictor
//
//  The LoginView is the view the user is first met with when
//  opening the app. It contains logic to allow the user to login
//  or give them an error message.
//
//  Created by Aaron Mathews on 5/7/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

/*
    The loginUser() function will send a POST request to the
    Mushroom Predictor API that is hosted in Microsoft Azure.
    This function will send the user entered username and password
    to the API and will get a JSON object back telling whether or not
    the user was allowed into the app or not.
*/
func loginUser(username: String, password: String, completionHandler: @escaping ([String: Any]) -> ()) -> () {
    
    // Create a Swift dictionary
    let json = [
        "username": username,
        "password": password
    ]
    
    // Convert Swift dictionary to JSON data object
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    // Create a URL object
    let url = URL(string: "https://mushroom-predictor.azurewebsites.net/get-user")!
    
    // Create a request object
    var request = URLRequest(url: url)
    
    // Set the request properties
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    // Send the request to the API
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        // Make sure data was returned
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        
        // Convert the JSON data to a Swift dictionary
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

        // If the responseJSON is of type [String: Any] run the
        // completionHandler()
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
    
    // The completionHandler() that will be passed to the loginUser()
    // function
    func completionHandler(input: [String: Any]) -> () {
        self.isLoading = true
        
        // Get the value from the dictionary
        let status = input["status"] as? String
        
        // If the status is valid log the user in
        if status == "valid" {
            self.callback(true)
            self.showLoginError = false
            self.showServerError = false
        // If the status is invalid show login error
        } else if status == "invalid" {
            self.callback(false)
            self.showLoginError = true
            self.showServerError = false
        // If the status is anything else show the server error
        } else {
            self.callback(false)
            self.showLoginError = false
            self.showServerError = true
        }
        
        self.isLoading = false
    }
    
    var body: some View {
        VStack {
            // Login view header
            VStack(alignment: .center) {
                Image("MushroomLogo")
                Text("Mushroom Predictor")
                    .font(.title)
            } // End of header for login form
            
            // Login form
            VStack(alignment: .leading) {
                // Login error message / server error message
                if self.showLoginError {
                    Text("Incorrect email or passowrd...")
                        .foregroundColor(Color.red)
                        .padding(.bottom, 5)
                } else if self.showServerError {
                    Text("An error has occurred. Please try again...")
                        .foregroundColor(Color.red)
                        .padding(.bottom, 5)
                }
                
                // Email input area
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
                
                // Password input area
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
                // Display the loading indicator as an overlay for
                // the section
                ZStack {
                    if self.isLoading {
                        Color.white
                    }
                    ActivityIndicator(isAnimating: self.$isLoading)
                }
            )
            
            // The button that fires the login event
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

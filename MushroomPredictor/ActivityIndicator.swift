//
//  ActivityIndicator.swift
//  MushroomPredictor
//
//  This view is used to indicate to a user that something is
//  loading.
//
//  Created by Aaron Mathews on 5/11/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    
    // Is ran when the view is first rendered
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    // Is ran when the view is to be updated
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
        // If the view is animating animate it, else stop animating
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

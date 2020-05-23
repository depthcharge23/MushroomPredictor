//
//  PredictorView.swift
//  MushroomPredictor
//
//  The PredictorView is the most complicated view. It holds lists
//  of all of the possible mushroom properties and values and lets
//  the user pick from those values to run predictions. This view
//  also handles sending the request to the Azure API, validating
//  user input, showing the result message, showing error message,
//  and indicating that the prediction is running.
//
//  Created by Aaron Mathews on 5/2/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//
import SwiftUI

struct PredictorView: View {
    
    // Mushroom property lists
    var capShape: [String] = ["Unknown", "Bell", "Conical", "Convex", "Flat", "Knobbed", "Sunken"]
    
    var capSurface: [String] = ["Unknown", "Fibrous", "Grooves", "Scaly", "Smooth"]
    
    var capColor: [String] = ["Unknown", "Brown", "Buff", "Cinnamon", "Gray", "Green", "Pink", "Purple", "Red", "White", "Yellow"]
    
    var bruises: [String] = ["Unknown", "Yes", "No"]
    
    var odor: [String] = ["Unknown", "Almond", "Anise", "Creosote", "Fishy", "Foul", "Musty", "Pungent", "Spicy", "None"]
    
    var gillAttachment: [String] = ["Unknown", "Attached", "Descending", "Free", "Notched"]
    
    var gillSpacing: [String] = ["Unknown", "Close", "Crowded", "Distant"]
    
    var gillSize: [String] = ["Unknown", "Broad", "Narrow"]
    
    var gillColor: [String] = ["Unknown", "Black", "Brown", "Buff", "Chocolate", "Gray", "Green", "Orange", "Pink", "Purple", "Red", "White", "Yellow"]
    
    var stalkShape: [String] = ["Unknown", "Enlarging", "Tapering"]
    
    var stalkRoot: [String] = ["Unknown", "Bulbous", "Club", "Cup", "Equal", "Rhizomorphs", "Rooted", "Missing"]
    
    var stalkSurfaceAboveRing: [String] = ["Unknown", "Fibrous", "Scaly", "Silky", "Smooth"]
    
    var stalkSurfaceBelowRing: [String] = ["Unknown", "Fibrous", "Scaly", "Silky", "Smooth"]
    
    var stalkColorAboveRing: [String] = ["Unknown", "Brown", "Buff", "Cinnamon", "Gray", "Orange", "Pink", "Red", "White", "Yellow"]
    
    var stalkColorBelowRing: [String] = ["Unknown", "Brown", "Buff", "Cinnamon", "Gray", "Orange", "Pink", "Red", "White", "Yellow"]
    
    var veilType: [String] = ["Unknown", "Partial", "Universal"]
    
    var veilColor: [String] = ["Unknown", "Brown", "Orange", "White", "Yellow"]
    
    var ringNumber: [String] = ["Unknown", "One", "Two", "None"]
    
    var ringType: [String] = ["Unknown", "Cobwebby", "Evanescent", "Flaring", "Large", "Pendant", "Sheathing", "Zone", "None"]
    
    var sporePrintColor: [String] = ["Unknown", "Black", "Brown", "Buff", "Chocolate", "Green", "Orange", "Purple", "White", "Yellow"]
    
    var population: [String] = ["Unknown", "Abundant", "Clustered", "Numerous", "Scattered", "Several", "Solitary"]
    
    var habitat: [String] = ["Unknown", "Grasses", "Leaves", "Meadows", "Paths", "Urban", "Waste", "Woods"]
    
    // Selected mushroom properties
    @State private var selectedCapShape: Int = 0
    @State private var selectedCapSurface: Int = 0
    @State private var selectedCapColor: Int = 0
    @State private var selectedBruises: Int = 0
    @State private var selectedOdor: Int = 0
    @State private var selectedGillAttachment: Int = 0
    @State private var selectedGillSpacing: Int = 0
    @State private var selectedGillSize: Int = 0
    @State private var selectedGillColor: Int = 0
    @State private var selectedStalkShape: Int = 0
    @State private var selectedStalkRoot: Int = 0
    @State private var selectedStalkSurfaceAboveRing: Int = 0
    @State private var selectedStalkSurfaceBelowRing: Int = 0
    @State private var selectedStalkColorAboveRing: Int = 0
    @State private var selectedStalkColorBelowRing: Int = 0
    @State private var selectedVeilType: Int = 0
    @State private var selectedVeilColor: Int = 0
    @State private var selectedRingNumber: Int = 0
    @State private var selectedRingType: Int = 0
    @State private var selectedSporePrintColor: Int = 0
    @State private var selectedPopulation: Int = 0
    @State private var selectedHabitat: Int = 0
    
    @State private var isLoading: Bool = false
    
    @State var prediction = ""
    @State var confidence = 0.0
    @State var errorMsg = ""
    
    @State var validationError = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Mushroom Predictor")
                    .font(.largeTitle)
                
                // The area where all of the drop down mushroom prop
                // menus live
                GeometryReader { geometry in
                    ScrollView {
                        VStack(alignment: .leading) {
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Cap Style")
                                        .font(.title)
                                    
                                    DropDownMenu(label: "Cap Shape", menuVals: self.capShape, alignment: .leading, callback: {
                                        selected in
                                        self.selectedCapShape = self.capShape.firstIndex(of: selected) ?? 0
                                    }, selected: self.capShape[self.selectedCapShape])
                                    
                                    DropDownMenu(label: "Cap Surface", menuVals: self.capSurface, alignment: .leading, callback: {
                                        selected in
                                        self.selectedCapSurface = self.capSurface.firstIndex(of: selected) ?? 0
                                    }, selected: self.capSurface[self.selectedCapSurface])
                                    
                                    DropDownMenu(label: "Cap Color", menuVals: self.capColor, alignment: .leading, callback: {
                                        selected in
                                        self.selectedCapColor = self.capColor.firstIndex(of: selected) ?? 0
                                    }, selected: self.capColor[self.selectedCapColor])
                                } // End Cap VStack
                            } // End Cap Group
                            .padding(.bottom)
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Gill Style")
                                        .font(.title)
                                    
                                    DropDownMenu(label: "Gill Attachment", menuVals: self.gillAttachment, alignment: .leading, callback: {
                                        selected in
                                        self.selectedGillAttachment = self.gillAttachment.firstIndex(of: selected) ?? 0
                                    }, selected: self.gillAttachment[self.selectedGillAttachment])
                                    
                                    DropDownMenu(label: "Gill Spacing", menuVals: self.gillSpacing, alignment: .leading, callback: {
                                        selected in
                                        self.selectedGillSpacing = self.gillSpacing.firstIndex(of: selected) ?? 0
                                    }, selected: self.gillSpacing[self.selectedGillSpacing])
                                    
                                    DropDownMenu(label: "Gill Size", menuVals: self.gillSize, alignment: .leading, callback: {
                                        selected in
                                        self.selectedGillSize = self.gillSize.firstIndex(of: selected) ?? 0
                                    }, selected: self.gillSize[self.selectedGillSize])
                                    
                                    DropDownMenu(label: "Gill Color", menuVals: self.gillColor, alignment: .leading, callback: {
                                        selected in
                                        self.selectedGillColor = self.gillColor.firstIndex(of: selected) ?? 0
                                    }, selected: self.gillColor[self.selectedGillColor])
                                } // End Gill VStack
                            } // End Gill Group
                            .padding(.bottom)
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Stalk Style")
                                        .font(.title)
                                    
                                    DropDownMenu(label: "Stalk Shape", menuVals: self.stalkShape, alignment: .leading, callback: {
                                        selected in
                                        self.selectedStalkShape = self.stalkShape.firstIndex(of: selected) ?? 0
                                    }, selected: self.stalkShape[self.selectedStalkShape])
                                    
                                    DropDownMenu(label: "Stalk Root", menuVals: self.stalkRoot, alignment: .leading, callback: {
                                        selected in
                                        self.selectedStalkRoot = self.stalkRoot.firstIndex(of: selected) ?? 0
                                    }, selected: self.stalkRoot[self.selectedStalkRoot])
                                    
                                    DropDownMenu(label: "Stalk Surface Above Ring", menuVals: self.stalkSurfaceAboveRing, alignment: .leading, callback: {
                                        selected in
                                        self.selectedStalkSurfaceAboveRing = self.stalkSurfaceAboveRing.firstIndex(of: selected) ?? 0
                                    }, selected: self.stalkSurfaceAboveRing[self.selectedStalkSurfaceAboveRing])
                                    
                                    DropDownMenu(label: "Stalk Surface Bellow Ring", menuVals: self.stalkSurfaceBelowRing, alignment: .leading, callback: {
                                        selected in
                                        self.selectedStalkSurfaceBelowRing = self.stalkSurfaceBelowRing.firstIndex(of: selected) ?? 0
                                    }, selected:  self.stalkSurfaceBelowRing[self.selectedStalkSurfaceBelowRing])
                                    
                                    DropDownMenu(label: "Stalk Color Above Ring", menuVals: self.stalkColorAboveRing, alignment: .leading, callback: {
                                        selected in
                                        self.selectedStalkColorAboveRing = self.stalkColorAboveRing.firstIndex(of: selected) ?? 0
                                    }, selected: self.stalkColorAboveRing[self.selectedStalkColorAboveRing])
                                    
                                    DropDownMenu(label: "Stalk Color Below Ring", menuVals: self.stalkColorBelowRing, alignment: .leading, callback: {
                                        selected in
                                        self.selectedStalkColorBelowRing = self.stalkColorBelowRing.firstIndex(of: selected) ?? 0
                                    }, selected: self.stalkColorBelowRing[self.selectedStalkColorBelowRing])
                                } // End Stalk VStack
                            } // End Stalk Group
                            .padding(.bottom)
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Veil Style")
                                        .font(.title)
                                    
                                    DropDownMenu(label: "Veil Type ", menuVals: self.veilType, alignment: .leading, callback: {
                                        selected in
                                        self.selectedVeilType = self.veilType.firstIndex(of: selected) ?? 0
                                    }, selected: self.veilType[self.selectedVeilType])
                                    
                                    DropDownMenu(label: "Veil Color", menuVals: self.veilColor, alignment: .leading, callback: {
                                        selected in
                                        self.selectedVeilColor = self.veilColor.firstIndex(of: selected) ?? 0
                                    }, selected: self.veilColor[self.selectedVeilColor])
                                } // End Veil VStack
                            } // End Veil Group
                            .padding(.bottom)
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Ring Style")
                                        .font(.title)
                                    
                                    DropDownMenu(label: "Ring Number", menuVals: self.ringNumber, alignment: .leading, callback: {
                                        selected in
                                        self.selectedRingNumber = self.ringNumber.firstIndex(of: selected) ?? 0
                                    }, selected: self.ringNumber[self.selectedRingNumber])
                                    
                                    DropDownMenu(label: "Ring Type", menuVals: self.ringType, alignment: .leading, callback: {
                                        selected in
                                        self.selectedRingType = self.ringType.firstIndex(of: selected) ?? 0
                                    }, selected: self.ringType[self.selectedRingType])
                                } // End Ring VStack
                            } // End Ring Group
                            .padding(.bottom)
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Misc")
                                        .font(.title)
                                    
                                    DropDownMenu(label: "Bruises", menuVals: self.bruises, alignment: .leading, callback: {
                                        selected in
                                        self.selectedBruises = self.bruises.firstIndex(of: selected) ?? 0
                                    }, selected: self.bruises[self.selectedBruises])
                                    
                                    DropDownMenu(label: "Odor", menuVals: self.odor, alignment: .leading, callback: {
                                        selected in
                                        self.selectedOdor = self.odor.firstIndex(of: selected) ?? 0
                                    }, selected: self.bruises[self.selectedBruises])
                                    
                                    DropDownMenu(label: "Spore Print Color", menuVals: self.sporePrintColor, alignment: .leading, callback: {
                                        selected in
                                        self.selectedSporePrintColor = self.sporePrintColor.firstIndex(of: selected) ?? 0
                                    }, selected: self.sporePrintColor[self.selectedSporePrintColor])
                                    
                                    DropDownMenu(label: "Population", menuVals: self.population, alignment: .leading, callback: {
                                        selected in
                                        self.selectedPopulation = self.population.firstIndex(of: selected) ?? 0
                                    }, selected: self.population[self.selectedPopulation])
                                    
                                    DropDownMenu(label: "Habitat", menuVals: self.habitat, alignment: .leading, callback: {
                                        selected in
                                        self.selectedHabitat = self.habitat.firstIndex(of: selected) ?? 0
                                    }, selected: self.habitat[self.selectedHabitat])
                                } // End Misc VStack
                            } // End Misc Group
                            .padding(.bottom)
                        } // End Scroll VStack
                    } // End Scroll View
                    .frame(width: geometry.size.width)
                } // End Geometry Reader
                .padding()
                .overlay(
                    ZStack {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    
                        if self.isLoading {
                            Color.white
                        }
                        
                        ActivityIndicator(isAnimating: self.$isLoading)
                    }
                )
                
                // The button that validates the data, and runs the
                // predictor request
                Button(action: {var flag: Bool = true
                    
                    // Start selected prop validation
                    // If any prop isn't filled out throw a
                    // validation error
                    if self.$selectedCapShape.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedCapSurface.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedCapColor.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedGillAttachment.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedGillSpacing.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedGillSize.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedGillColor.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedStalkShape.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedStalkRoot.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedStalkColorAboveRing.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedStalkColorBelowRing.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedStalkSurfaceAboveRing.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedStalkSurfaceBelowRing.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedVeilType.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedVeilColor.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedRingType.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedRingNumber.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedBruises.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedOdor.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedSporePrintColor.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedPopulation.wrappedValue == 0 {
                        flag = false
                    }
                    
                    if self.$selectedHabitat.wrappedValue == 0 {
                        flag = false
                    }
                    
                    // If the flag is still true, run the prediction
                    // Else show validation message
                    if flag {
                        let predictor = Predictor()
                        self.isLoading = true
                        
                        predictor.postJson(capShape: self.$selectedCapShape.wrappedValue, capSurface: self.$selectedCapSurface.wrappedValue, capColor: self.$selectedCapColor.wrappedValue, bruises: self.$selectedBruises.wrappedValue, odor: self.$selectedOdor.wrappedValue, gillAttachment: self.$selectedGillAttachment.wrappedValue, gillSpacing: self.$selectedGillSpacing.wrappedValue, gillSize: self.$selectedGillSize.wrappedValue, gillColor: self.$selectedGillColor.wrappedValue, stalkShape: self.$selectedStalkShape.wrappedValue, stalkRoot: self.$selectedStalkRoot.wrappedValue, stalkSurfaceAboveRing: self.$selectedStalkSurfaceAboveRing.wrappedValue, stalkSurfaceBelowRing: self.$selectedStalkSurfaceBelowRing.wrappedValue, stalkColorAboveRing: self.$selectedStalkColorAboveRing.wrappedValue, stalkColorBelowRing: self.$selectedStalkColorBelowRing.wrappedValue, veilType: self.$selectedVeilType.wrappedValue, veilColor: self.$selectedVeilColor.wrappedValue, ringNumber: self.$selectedRingNumber.wrappedValue, ringType: self.$selectedRingType.wrappedValue, sporePrintColor: self.$selectedSporePrintColor.wrappedValue, population: self.$selectedPopulation.wrappedValue, habitat: self.$selectedHabitat.wrappedValue) { result in
                            
                           // If there is a prediction prop value,
                           // set the prediction value
                           if let prediction = result["prediction"] as? Int {
                                
                                // 1 correlates to Poisonous, and
                                // 2 correlates to Edible, anything
                                // esle is an error
                                if prediction == 1 {
                                    self.prediction = "Poisonous"
                                } else if prediction == 2 {
                                    self.prediction = "Edible"
                                } else {
                                    self.prediction = "Unknown"
                                }
                            } else {
                                self.prediction = "Unknown"
                            }
                            
                            // If there is confidence prop value,
                            // turn the confidence value into a
                            // percentage.
                            if let confidence = result["confidence"] as? Int {
                                self.confidence = Double(confidence) * 100.0
                            } else {
                                self.confidence = -1.0
                            }
                            
                            // If there is an error prop value,
                            // set the error message
                            if let error = result["error"] as? String {
                                self.errorMsg = error
                            }
                        }
                        
                        self.isLoading = false
                    } else {
                        self.validationError = true
                    }
                    
                }) {
                    Text("Submit")
                        .foregroundColor(Color.green)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.green, lineWidth: 3)
                        )
                }
                .padding(.top)
            }
            
            // Show the validation error when there is one
            if self.validationError {
                VStack {
                    Text("Please fill out all of the criteria...")
                        .padding()
                    
                    Button(action: {
                        self.validationError = false
                    }) {
                        Text("Close")
                            .padding(10)
                            .foregroundColor(Color.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.red, lineWidth:  3)
                            )
                    }
                    .padding(.bottom, 10)
                }
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            // Show the error message when there is one
            } else if self.errorMsg != "" {
                VStack {
                    Text(self.errorMsg)
                        .padding()
                    
                    Button(action: {
                        self.errorMsg = ""
                    }) {
                        Text("Close")
                            .foregroundColor(Color.red)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    .padding(.bottom)
                }
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
            // Show the mushroom results
            } else {
                if (self.prediction != "" && self.confidence != -1.0) {
                    VStack {
                        MushroomResultView(prediction: prediction, confidence: confidence)
                            .padding()
                        
                        Button(action: {
                            self.prediction = ""
                            self.confidence = -1.0
                        }) {
                            Text("Close")
                                .padding(10)
                                .foregroundColor(Color.red)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.red, lineWidth: 3)
                                )
                        }
                        .padding(.bottom, 10)
                    }
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
            }
        } // End of ZStack
    } // End of body
}

struct PredictorView_Previews: PreviewProvider {
    static var previews: some View {
        PredictorView()
    }
}

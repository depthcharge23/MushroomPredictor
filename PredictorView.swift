//
//  PredictorView.swift
//  MushroomPredictor
//
//  Created by Aaron Mathews on 5/2/20.
//  Copyright © 2020 Aaron Mathews. All rights reserved.
//

import SwiftUI

struct PredictorView: View {
    
    var capShape: [[String]] = [["", ""], ["Bell", "b"], ["Conical", "c"], ["Convex", "x"], ["Flat", "f"], ["Knobbed", "k"], ["Sunken", "s"]]
    
    var capSurface: [[String]] = [["", ""], ["Fibrous", "f"], ["Grooves", "g"], ["Scaly", "y"], ["Smooth", "s"]]
    
    var capColor: [[String]] = [["", ""], ["Brown", "n"], ["Buff", "b"], ["Cinnamon", "c"], ["Gray", "g"], ["Green", "r"], ["Pink", "p"], ["Purple", "u"], ["Red", "e"], ["White", "w"], ["Yellow", "y"]]
    
    var bruises: [[String]] = [["Yes", "t"], ["No", "F"]]
    
    var odor: [[String]] = [["", ""], ["Almond", "a"], ["Anise", "l"], ["Creosote", "c"], ["Fishy", "y"], ["Foul", "f"], ["Musty", "m"], ["Pungent", "p"], ["Spicy", "s"], ["None", "n"]]
    
    var gillAttachment: [[String]] = [["", ""], ["Attached", "a"], ["Descending", "d"], ["Free", "f"], ["Notched", "n"]]
    
    var gillSpacing: [[String]] = [["", ""], ["Close", "c"], ["Crowded", "w"], ["Distant", "d"]]
    
    var gillSize: [[String]] = [["", ""], ["Broad", "b"], ["Narrow", "n"]]
    
    var gillColor: [[String]] = [["", ""], ["Black", "k"], ["Brown", "n"], ["Buff", "b"], ["Chocolate", "h"], ["Gray", "g"], ["Green", "r"], ["Orange", "o"], ["Pink", "p"], ["Purple", "u"], ["Red", "e"], ["White", "w"], ["Yellow", "y"]]
    
    var stalkShape: [[String]] = [["", ""], ["Enlarging", "e"], ["Tapering", "t"]]
    
    var stalkRoot: [[String]] = [["", ""], ["Bulbous", "b"], ["Club", "c"], ["Cup", "u"], ["Equal", "e"], ["Rhizomorphs", "z"], ["Rooted", "r"], ["Missing", "?"]]
    
    var stalkSurfaceAboveRing: [[String]] = [["", ""], ["Fibrous", "f"], ["Scaly", "y"], ["Silky", "k"], ["Smooth", "s"]]
    
    var stalkSurfaceBelowRing: [[String]] = [["", ""], ["Fibrous", "f"], ["Scaly", "y"], ["Silky", "k"], ["Smooth", "s"]]
    
    var stalkColorAboveRing: [[String]] = [["", ""], ["Brown", "n"], ["Buff", "b"], ["Cinnamon", "c"], ["Gray", "g"], ["Orange", "o"], ["Pink", "p"], ["Red", "e"], ["White", "w"], ["Yellow", "y"]]
    
    var stalkColorBelowRing: [[String]] = [["", ""], ["Brown", "n"], ["Buff", "b"], ["Cinnamon", "c"], ["Gray", "g"], ["Orange", "o"], ["Pink", "p"], ["Red", "e"], ["White", "w"], ["Yellow", "y"]]
    
    var veilType: [[String]] = [["", ""], ["Partial", "p"], ["Universal","u"]]
    
    var veilColor: [[String]] = [["", ""], ["Brown", "n"], ["Orange", "o"], ["White", "w"], ["Yellow", "y"]]
    
    var ringNumber: [[String]] = [["", ""], ["One", "o"], ["Two", "t"], ["None", "n"]]
    
    var ringType: [[String]] = [["", ""], ["Cobwebby", "c"], ["Evanescent", "e"], ["Flaring", "f"], ["Large", "l"], ["Pendant", "p"], ["Sheathing", "s"], ["Zone", "z"], ["None", "n"]]
    
    var sporePrintColor: [[String]] = [["", ""], ["Black", "k"], ["Brown", "n"], ["Buff", "b"], ["Chocolate", "h"], ["Green", "e"], ["Orange", "o"], ["Purple", "u"], ["White", "w"], ["Yellow", "y"]]
    
    var population: [[String]] = [["", ""], ["Abundant", "a"], ["Clustered", "c"], ["Numerous", "n"], ["Scattered", "s"], ["Several", "v"], ["Solitary", "y"]]
    
    var habitat: [[String]] = [["", ""], ["Grasses", "g"], ["Leaves", "l"], ["Meadows", "m"], ["Paths", "p"], ["Urban", "u"], ["Waste", "w"], ["Woods", "d"]]
    
    @State private var selectedCapShape = 0
    @State private var selectedCapSurface = 0
    @State private var selectedCapColor = 0
    @State private var selectedBruises = 0
    @State private var selectedOdor = 0
    @State private var selectedGillAttachment = 0
    @State private var selectedGillSpacing = 0
    @State private var selectedGillSize = 0
    @State private var selectedGillColor = 0
    @State private var selectedStalkShape = 0
    @State private var selectedStalkRoot = 0
    @State private var selectedStalkSurfaceAboveRing = 0
    @State private var selectedStalkSurfaceBelowRing = 0
    @State private var selectedStalkColorAboveRing = 0
    @State private var selectedStalkColorBelowRing = 0
    @State private var selectedVeilType = 0
    @State private var selectedVeilColor = 0
    @State private var selectedRingNumber = 0
    @State private var selectedRingType = 0
    @State private var selectedSporePrintColor = 0
    @State private var selectedPopulation = 0
    @State private var selectedHabitat = 0
    
    @State var prediction = ""
    @State var confidence = 0.0
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Text("The more information you fill out, the more accurate the prediction will be...")
                        .font(.subheadline)
                    
                    Section(header: Text("Cap Style")) {
                        Picker(selection: $selectedCapShape, label: Text("Cap Shape")) {
                            ForEach(0 ..< capShape.count) {
                                Text(self.capShape[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedCapSurface, label: Text("Cap Surface")) {
                            ForEach(0 ..< capSurface.count) {
                                Text(self.capSurface[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedCapColor, label: Text("Cap Color")) {
                            ForEach(0 ..< capColor.count) {
                                Text(self.capColor[$0][0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Gill Style")) {
                        Picker(selection: $selectedGillAttachment, label: Text("Gill Attachment")) {
                            ForEach(0 ..< gillAttachment.count) {
                                Text(self.gillAttachment[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedGillSpacing, label: Text("Gill Spacing")) {
                            ForEach(0 ..< gillSpacing.count) {
                                Text(self.gillSpacing[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedGillSize, label: Text("Gill Size")) {
                            ForEach(0 ..< gillSize.count) {
                                Text(self.gillSize[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedGillColor, label: Text("Gill Color")) {
                            ForEach(0 ..< gillColor.count) {
                                Text(self.gillColor[$0][0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Stalk Style")) {
                        Picker(selection: $selectedStalkShape, label: Text("Stalk Shape")) {
                            ForEach(0 ..< stalkShape.count) {
                                Text(self.stalkShape[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedStalkRoot, label: Text("Stalk Root")) {
                            ForEach(0 ..< stalkRoot.count) {
                                Text(self.stalkRoot[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedStalkSurfaceAboveRing, label: Text("Stalk Surface Above Ring")) {
                            ForEach(0 ..< stalkSurfaceAboveRing.count) {
                                Text(self.stalkSurfaceAboveRing[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedStalkSurfaceBelowRing, label: Text("Stalk Surface Below Ring")) {
                            ForEach(0 ..< stalkSurfaceBelowRing.count) {
                                Text(self.stalkSurfaceBelowRing[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedStalkColorAboveRing, label: Text("Stalk Color Above Ring")) {
                            ForEach(0 ..< stalkColorAboveRing.count) {
                                Text(self.stalkColorAboveRing[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedStalkColorBelowRing, label: Text("Stalk Color Below Ring")) {
                            ForEach(0 ..< stalkColorBelowRing.count) {
                                Text(self.stalkColorBelowRing[$0][0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Veil Style")) {
                        Picker(selection: $selectedVeilType, label: Text("Veil Type")) {
                            ForEach(0 ..< veilType.count) {
                                Text(self.veilType[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedVeilColor, label: Text("Veil Color")) {
                            ForEach(0 ..< veilColor.count) {
                                Text(self.veilColor[$0][0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Ring Style")) {
                        Picker(selection: $selectedRingNumber, label: Text("Ring Number")) {
                            ForEach(0 ..< ringNumber.count) {
                                Text(self.ringNumber[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedRingType, label: Text("Ring Type")) {
                            ForEach(0 ..< ringType.count) {
                                Text(self.ringType[$0][0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Miscellaneous")) {
                        Picker(selection: $selectedBruises, label: Text("Bruises")) {
                            ForEach(0 ..< bruises.count) {
                                Text(self.bruises[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedOdor, label: Text("Odor")) {
                            ForEach(0 ..< odor.count) {
                                Text(self.odor[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedSporePrintColor, label: Text("Spore Print Color")) {
                            ForEach(0 ..< sporePrintColor.count) {
                                Text(self.sporePrintColor[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedPopulation, label: Text("Population")) {
                            ForEach(0 ..< population.count) {
                                Text(self.population[$0][0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedHabitat, label: Text("Habitat")) {
                            ForEach(0 ..< habitat.count) {
                                Text(self.habitat[$0][0]).tag($0)
                            }
                        }
                    }
                    
                    Button(action: {
                        let predictor = Predictor()
                        
                        predictor.postJson(capShape: self.$selectedCapShape.wrappedValue, capSurface: self.$selectedCapSurface.wrappedValue, capColor: self.$selectedCapColor.wrappedValue, bruises: self.$selectedBruises.wrappedValue, odor: self.$selectedOdor.wrappedValue, gillAttachment: self.$selectedGillAttachment.wrappedValue, gillSpacing: self.$selectedGillSpacing.wrappedValue, gillSize: self.$selectedGillSize.wrappedValue, gillColor: self.$selectedGillColor.wrappedValue, stalkShape: self.$selectedStalkShape.wrappedValue, stalkRoot: self.$selectedStalkRoot.wrappedValue, stalkSurfaceAboveRing: self.$selectedStalkSurfaceAboveRing.wrappedValue, stalkSurfaceBelowRing: self.$selectedStalkSurfaceBelowRing.wrappedValue, stalkColorAboveRing: self.$selectedStalkColorAboveRing.wrappedValue, stalkColorBelowRing: self.$selectedStalkColorBelowRing.wrappedValue, veilType: self.$selectedVeilType.wrappedValue, veilColor: self.$selectedVeilColor.wrappedValue, ringNumber: self.$selectedRingNumber.wrappedValue, ringType: self.$selectedRingType.wrappedValue, sporePrintColor: self.$selectedSporePrintColor.wrappedValue, population: self.$selectedPopulation.wrappedValue, habitat: self.$selectedHabitat.wrappedValue) { result in
                            
                           if let prediction = result["prediction"] as? Int {
                                if prediction == 1 {
                                    self.prediction = "Poisonous"
                                } else if prediction == 2 {
                                    self.prediction = "Edible"
                                } else {
                                    self.prediction = "Unknown"
                                }
                            } else {
                                self.prediction = "Unkown"
                            }
                            
                            if let confidence = result["confidence"] as? Int {
                                self.confidence = Double(confidence) * 100.0
                            } else {
                                self.confidence = 0.0
                            }
                        }
                    }) {
                        Text("Submit")
                    }
                }
                .padding()
                .navigationBarTitle("Mushroom Predictor")
            }
            
            if (self.prediction != "" && self.confidence != -1.0) {
                VStack {
                    MushroomResultView(prediction: prediction, confidence: confidence)
                        .padding()
                    
                    Button(action: {
                        self.prediction = ""
                        self.confidence = -1.0
                    }) {
                        Text("Close")
                    }
                }
                .background(Color.red)
            }
        }
    }
}

struct PredictorView_Previews: PreviewProvider {
    static var previews: some View {
        PredictorView(prediction: "", confidence: -1.0)
    }
}

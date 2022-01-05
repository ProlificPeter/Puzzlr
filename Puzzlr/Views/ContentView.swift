//
//  ContentView.swift
//  Puzzlr
//
//  Created by Peter Granlund on 1/4/22.
//

import SwiftUI



struct ContentView: View {
    @State private var foundCode: String = ""
    @State private var rewardResponseIsVisible: Bool = false
    
    var body: some View {
        VStack {
            VStack{
                Text("Code Translator")
                    .padding()
                TextField("Code",
                          text: $foundCode)
                    .padding(.horizontal)
                    .frame(width: 100.0)
                    .multilineTextAlignment(.center)
                Button(action: {
                    self.rewardResponseIsVisible = true
                }) {
                    Text("Translate")
                }
            }
            if rewardResponseIsVisible {
                Text("Placeholder Reward Text")
                    .padding(.top, 50.0)
                    .foregroundColor(.purple)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

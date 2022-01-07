//
//  ContentView.swift
//  Puzzlr
//
//  Created by Peter Granlund on 1/4/22.
//

import SwiftUI



struct ContentView: View {
    @State private var translator: Translator = Translator()
    @State private var foundCode: String = ""
    @State private var rewardResponseIsVisible: Bool = false
	@State private var messages = [Message]()
	@State private var callIsSuccessful: Bool = false
	
	func loadData() async {
		//TODO: figure out URLSession Configuration
		//let configuration = URLSessionConfiguration.ephemeral
		guard let url = URL(string: "https://raw.githubusercontent.com/ProlificPeter/Puzzlr/main/Puzzlr/appdata.json") else {
			print("Invalid URL")
			return
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			
					
			let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
			messages = decodedResponse.messages
			
			print(messages[0].message)
			callIsSuccessful = true
			
		} catch {
			print(error)
		}
		
		
	}
    
    var body: some View {
        VStack {
			VStack {
				if callIsSuccessful {
					ForEach(messages, id: \.self) { message in
						if message.isAvailable {
							Text(message.message)
								.padding(.all)
						}
					}
				}
				
			}
			.task {
				await loadData()
			}
            VStack{
                Text("Code Translator")
                    .padding()
                TextField("Code",
                          text: $foundCode)
                    .padding(.horizontal)
                    .frame(width: 100.0)
                    .multilineTextAlignment(.center)
                    .disabled(rewardResponseIsVisible)
                    .onSubmit {
                        self.rewardResponseIsVisible = true
                    }
                Button(action: {
                    self.rewardResponseIsVisible = true
                }) {
                    Text("Translate")
                }
                .disabled(rewardResponseIsVisible)
            }
            if rewardResponseIsVisible {
                let result = translator.translateCode(input: foundCode.uppercased())
                if result.0 {
                    Text(result.1)
                        .padding(.top, 50.0)
                        .foregroundColor(.purple)
                }
                else {
                    Text(result.1)
                        .padding(.top, 50.0)
                        .foregroundColor(.red)
                }
                Button(action: {
                    rewardResponseIsVisible.toggle()
                    foundCode = ""
                }) {
                    Text("Try Again")
                }
                .padding(.top)
                .disabled(!rewardResponseIsVisible)

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
    


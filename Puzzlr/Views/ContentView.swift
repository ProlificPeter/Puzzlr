//
//  ContentView.swift
//  Puzzlr
//
//  Created by Peter Granlund on 1/4/22.
//

import SwiftUI



struct ContentView: View {
    @State private var codex = Codex()
    @State private var foundCode: String = ""
    @State private var rewardResponseIsVisible: Bool = false
	@State private var messages = [Message]()
	@State private var translations = [String : String]()
	@State private var responseCallIsSuccessful: Bool = false
	@State private var translationCallIsSuccessful: Bool = false
	
	func loadData() async {
		
		Network().getResponses { result in
			switch result {
			case.success(let messages):
				DispatchQueue.main.async {
					self.messages = messages
					responseCallIsSuccessful = true
				}
				
			case.failure(let error):
				print(error.localizedDescription)
				responseCallIsSuccessful = false
			}
		}
		
		Network().getTranslations { result in
			switch result {
			case.success(let translation):
				DispatchQueue.main.async {
					self.translations = translation
					translationCallIsSuccessful = true
				}
			case.failure(let error):
				print(error.localizedDescription)
				translationCallIsSuccessful = false
			}
		}
		
		/* TODO: figure out URLSession Configuration */
		//let configuration = URLSessionConfiguration.ephemeral
		/*guard let url = URL(string: "https://raw.githubusercontent.com/ProlificPeter/Puzzlr/main/Puzzlr/appdata.json") else {
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
		
		*/
	}
    
    var body: some View {
        VStack {
			VStack {
				if responseCallIsSuccessful {
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
					if translationCallIsSuccessful {
						Text("Translate")
					}
					else {
						Text("Network Response Error")
							.disabled(true)
					}
                }
                .disabled(rewardResponseIsVisible)
            }
            if rewardResponseIsVisible {
                let result = codex.translateCode(input: foundCode.uppercased(), translation: translations)
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
    


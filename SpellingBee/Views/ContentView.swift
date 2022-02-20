//
//  ContentView.swift
//  SpellingBee
//
//  Created by Russell Gordon on 2022-02-16.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State var currentItem = itemsToSpell.randomElement()!
    @State var inputGiven  = ""
    @State var answerChecked = false
    @State var answerCorrect = false
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            Image(currentItem.imageName)
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    
                    // Create the word to be spoken (an utterance) and set
                    // characteristics of how the voice will sound
                    let utterance = AVSpeechUtterance(string: currentItem.word)
                    
                    // See a list of available language codes and their corresponding
                    // voice names and genders here:
                    // https://www.ikiapps.com/tips/2015/12/30/setting-voice-for-tts-in-ios
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                    
                    // How fast the utterance will be spoken
                    utterance.rate = 0.5
                    
                    // Synthesize (speak) the utterance
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                    
                }
            
            Divider()
            
            HStack {
                ZStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .opacity(answerCorrect == true ? 1.0 : 0.0)
                    
                    Image(systemName: "x.square")
                        .foregroundColor(.red)
                        .opacity(answerChecked == true && answerCorrect == false ? 1.0 : 0.0)
                }
                
                Spacer()
                
                TextField("",
                          text: $inputGiven)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
            }
            
            ZStack {
                
                Button(action: {
                    
                    answerChecked = true
                    
                    if inputGiven == currentItem.word {
                        answerCorrect = true
                    } else {
                        answerCorrect = false
                    }
                }, label: {
                    Text("Check Answer")
                })
                    .padding()
                    .buttonStyle(.bordered)
                    .opacity(answerChecked == false ? 1.0 : 0.0)
                
                Button(action: {
                    currentItem = itemsToSpell.randomElement()!
                    answerChecked = false
                    answerCorrect = false
                    inputGiven = ""
                }, label: {
                    Text("New question")
                })
                    .padding()
                    .buttonStyle(.bordered)
                    .opacity(answerChecked == true ? 1.0 : 0.0)
                
                Spacer()
                
            }
            .padding()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

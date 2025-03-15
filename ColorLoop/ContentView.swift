//
//  ContentView.swift
//  ColorLoop
//
//  Created by たお1219 on 2024/11/20.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var timer: Timer? = nil
    @State private var timer2: Timer? = nil
    @State private var isButtonClicked = false
    @State private var imageIndex = 0
    @State private var offsetY:CGFloat = CGFloat(-170)
    @State private var audioPlayer: AVAudioPlayer?
    @State private var backgroundAudioPlayer: AVAudioPlayer? // play bgm
    @State private var soundEffectAudioPlayer: AVAudioPlayer? // play sound
    private let backgroundImages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
    
    var body: some View {
        ZStack{
            Image("\(backgroundImages[imageIndex])")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Image("title")
                    .offset(y:offsetY)
                Spacer()
                HStack{
                    
                    Button(action:{
                        imageLoop()
                        titleMove()
                        playSound(named:"meow1")
                        isButtonClicked = true
                    },label:{
                        Image("btn1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                    })
                    .disabled(isButtonClicked)
                    
                    Button(action:{
                        imageStop()
                        playSound(named:"meow2")
                    },label:{
                        Image("btn2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 105)
                    })
                    
                    Button(action:{
                        btnReset()
                        playSound(named:"meow3")
                    },label:{
                        Image("btn3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 105)
                    })
                }
            }
            
        }
        .onAppear(){
            BackgroundMusic()
        }
    }
    func imageLoop(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            if imageIndex < 21{
                imageIndex += 1
            }else{
                imageIndex=0
            }
        }
    }
    func imageStop(){
        timer?.invalidate()
        self.timer = nil
        timer2?.invalidate()
        self.timer2 = nil
        
    }
    
    func titleMove(){
        timer2 = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {_ in
            if offsetY < 750 {
                offsetY += 2
            }else{
                offsetY = -100
            }
        }
    }
    
    func btnReset(){
        isButtonClicked = false
        offsetY = -170
        imageIndex = 0
        imageStop()
        titleMove()
        //        imageLoop()
        
    }
    
    func BackgroundMusic(){
        guard let soundURL = Bundle.main.url(forResource: "bgm", withExtension: "mp3") else { return }
        
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            backgroundAudioPlayer?.numberOfLoops = -1 // loop
            backgroundAudioPlayer?.play()
            
        } catch {
            print("bgm cannot be played: \(error.localizedDescription)")
        }
    }
    
    func playSound(named soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            soundEffectAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            soundEffectAudioPlayer?.play()
        } catch {
            print("sound cannot be played: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}

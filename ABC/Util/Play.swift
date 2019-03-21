//
//  Play.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/22.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import AVFoundation

private var audioPlayer = AVAudioPlayer()

let allLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
let alphaLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let lowerLetters = "abcdefghijklmnopqrstuvwxyz"
let upperLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let numberLetters = "0123456789"

let isZhHans = Bundle.main.preferredLocalizations.first == "zh-Hans"

func speech(letter: String, detail: Bool = false) {
    var path = ""
    
    if alphaLetters.contains(letter) {
        let lowerLetter = letter.lowercased()
        if detail {
            path = "voice/detail/\(lowerLetter)"
        } else {
            path = "voice/\(lowerLetter)"
        }
    } else {
        if isZhHans {
            path = "voice/zh-Hans/\(letter)"
        } else {
            path = "voice/\(letter)"
        }
    }
    
    let sound = Bundle.main.path(forResource: path, ofType: "mp3")
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
    } catch {
        
    }
    
    audioPlayer.play()
}

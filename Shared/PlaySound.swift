//
//  PlaySound.swift
//  ResimliSudoku
//
//  Created by Levent yadırga on 1.02.2022.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Ses dosyası çalınamadı")
        }
    }
}



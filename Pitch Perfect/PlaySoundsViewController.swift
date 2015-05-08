//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mary Elizabeth McManamon on 4/26/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation



class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

    }
    
   
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
         playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playChipmuckAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func speedMeUp(sender: UIButton) {
        
        playAllAudio(1.5)
    }
    
    @IBAction func slowMeDown(sender: UIButton) {
        
        playAllAudio(0.5)
    }
    
    @IBAction func stopMeCold(sender: UIButton) {
        audioEngine.stop()
        audioPlayer.stop()
    }
    func playAllAudio (myRate: Float) {
        
        if (audioEngine.running) {
            audioEngine.stop()
            audioEngine.reset()
        }
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = myRate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        
        if (audioPlayer.playing) {
            audioPlayer.stop()
        }
        audioEngine.stop()
        audioEngine.reset()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }


   
}

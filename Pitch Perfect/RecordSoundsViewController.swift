//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mary Elizabeth McManamon on 4/26/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingText: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recordButton.enabled = true
        recordingText.hidden = false
        recordingText.text="Tap To Record"
        stopButton.hidden = true
    }

    
    @IBAction func recordAudio(sender: UIButton) {
         recordButton.enabled = false
         recordingText.text="Recording In Progess"
         recordingText.hidden = false
         stopButton.hidden = false
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [docsDir, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        
        // setup AudioSession
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

        
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
       if (flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            recordingText.text="Recording Unsucessful"
        }


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }

    }

    @IBAction func stopRecording(sender: UIButton) {
       
        recordingText.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}


//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Burak Tunc on 19.10.2019.
//  Copyright © 2019 Burak Tunc. All rights reserved.
//

import UIKit
import AVFoundation

//AVUadioRecorderDelegate Protocol Implements
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // instance of AVAudioRecorder class
    var audioRecorder: AVAudioRecorder!
    
    // UILabels and UIButtons
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad is Called")
        
        //Stop Recording Button Disable
        stopRecordingButton.isEnabled = false
    }
    
    // Record Audio Button Clicked
    
    // MARK: Record Audio
    @IBAction func recordAudio(_ sender: Any) {
        recordLabel.text = "Recording in progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        // File Path create
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(fileURLWithPath: pathArray.joined(separator: "/"))
        
        print(filePath)
        
        // AVAudioSession create
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        //Record an Audio!!
        try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    // MARK: Stop Recording
    
    // Stop recording button is clicked
    @IBAction func stopRecording(_ sender: Any) {
        recordLabel.text = "Stopped. Tap to Record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        
        //Stop recording
        audioRecorder.stop()
        //Session deactive
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    // MARK: When finished recording
    
    // Protocol method use
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording is finished")
            // Create a performSegue with audioRecorder instance url
            performSegue(withIdentifier: "stopRecordingSegueIdentifier", sender: audioRecorder.url)
        } else {
            
        }
        
    }
    
    // MARK: Preparing for Segue
    
    //prepare audio url data for segue 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegueIdentifier" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}


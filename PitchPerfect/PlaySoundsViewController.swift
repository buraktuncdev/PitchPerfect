//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Burak Tunc on 22.10.2019.
//  Copyright © 2019 Burak Tunc. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: URL!
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    // MARK: switch case button type
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
           case .slow:
               playSound(rate: 0.5)
           case .fast:
               playSound(rate: 1.5)
           case .chipmunk:
               playSound(pitch: 1000)
           case .vader:
               playSound(pitch: -1000)
           case .echo:
               playSound(echo: true)
           case .reverb:
               playSound(reverb: true)
           }

           configureUI(.playing)
    }

    
    // MARK: Stop Playing Audio
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    
    // MARK: set the stop button as not playing status, meaning of disables
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
}

//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var player: AVAudioPlayer?
    let eggTimes = ["Soft":5, "Medium":10,"Hard":15]
    var counter:Float = 0.1;
    var total:Float = 60;
    var timer = Timer()

    @IBOutlet weak var appTitle: UILabel!
    
 
    @IBOutlet weak var progressBar: UIProgressView!
    

    @objc func updateCounter() {
        //example functionality
        if counter < total  {
            appTitle.text = "Waiting.."
            print("\(counter) seconds")
            print(Float(counter/total))
            counter += 1
            progressBar.progress = Float(counter/total)
        }
        else{
            appTitle.text = "Done!"
            playSound()
            timer.invalidate()
        }
    }
    

 
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        print(sender.currentTitle!)
        counter = 0.1
        let hardness = sender.currentTitle
        total = Float(eggTimes[hardness!]!);
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

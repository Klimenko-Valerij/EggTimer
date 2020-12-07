//
//  ViewController.swift
//  EggTimer
//
//  Created by Валерий Клименко on 07.12.2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var timerProgress: UIProgressView!
  
  var player : AVAudioPlayer?
  
  let hardneses : [String : Int] = [  "soft"   : 300,
                                      "medium" : 420,
                                      "hard"   : 720]
  let stepTimer : Float = 1
  
  var timer: Timer?
  var totalTime = 0
  var secondsPassed = 0
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    if let nameOfHardness = sender.currentTitle {
      if let hardnes = hardneses[nameOfHardness.lowercased()] {
        totalTime = hardnes
        secondsPassed = 0
        timeLabel.text = nameOfHardness
        timerProgress.progress = 0.0
        
        if timer == nil {
          timer = Timer.scheduledTimer(timeInterval: Double(stepTimer), target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
      }
    }
  }
  
  @objc func update () {
    if secondsPassed < totalTime {
      secondsPassed += 1
      timerProgress.progress = Float(secondsPassed) / Float(totalTime)
    } else {
      timer!.invalidate()
      timer = nil
      timeLabel.text = "DONE!"
      
      let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
      player = try! AVAudioPlayer(contentsOf: url!)
      player!.play()
    }
  }

}


//
//  ViewController.swift
//  AnimalFarm
//
//  Created by Kim Yeon Jeong on 2019/12/7.
//  Copyright © 2019 Kim Yeon Jeong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    let dataArray = ["🐶 - 강아지 (狗)","🐱 - 고양이 (貓)","🐯 - 호랑이 (老虎)","🐔 - 닭 (雞)","🦆 - 오리 (鴨)","🐭 - 쥐 (老鼠)","🐮 - 소 (牛)","🐧 - 펭수 (PengSoo)"]
    
    var volume: Float!
    var repeatCount: Int!
         //write down animal matched sound
    let koreanWordsArray = ["멍멍","야옹","어흥","꼬끼오","꽥꽥","찍찍","음매","팽하"]
    
    var timer: Timer!
    
    @IBOutlet weak var animalFarm: UITableView!
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var repeatCountSlider: UISlider!
    
    @IBAction func volume(_ sender: UISlider) {
        volume = sender.value
    }
    
    @IBAction func repeatCount(_ sender: UISlider) {
    // repeat count controller
        repeatCount = Int(sender.value)
        
    
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        animalFarm.delegate = self
        animalFarm.dataSource = self
        
        volume = volumeSlider.value
        repeatCount = Int(repeatCountSlider.value)
    }


}

//match table view cell and user pick

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let koreanWordToSpeak = koreanWordsArray[indexPath.row]
        let synthesizer = AVSpeechSynthesizer()
        
        
       //set up repeats

        
        var timeLeft = Int(repeatCountSlider.value)
        print("timeLeft : \(timeLeft)")
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            timeLeft -= 1
            
            let speechUtterance = AVSpeechUtterance(string: koreanWordToSpeak)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            //sliderchanged -> change volume
            speechUtterance.volume = self.volume
            synthesizer.speak(speechUtterance)
            
            if timeLeft <= 0 {
                self.timer.invalidate()
                self.timer = nil
            }
        }
    }
}

// make tabelView
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get the data for this row
        let rowData = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:"animalFarm", for:indexPath)
        cell.textLabel?.text = rowData
        cell.textLabel!.font = UIFont.systemFont(ofSize: 22)
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

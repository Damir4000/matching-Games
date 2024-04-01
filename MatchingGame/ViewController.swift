//
//  ViewController.swift
//  MatchingGame
//
//  Created by Dias Narysov on 1/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stepCountLabel: UILabel!
    
    
   
    var imageNames = [
       "1","1","2","2","3","3","4","4","5","5","6","6","7","7","8","8"
    ]
    
    var isOpened = false // true
    var previousButtonTag = 0
    var isTimerEnabled = false
    var count = 0
    var steps = 0
    
    
    

    
    override func viewDidLoad() {
        steps = 0
        stepCountLabel.text = "количество шагов: \(steps)"
        super.viewDidLoad()
        clear()
    }
    
    func clear(){
        
        steps = 0
        
        stepCountLabel.text = "количество шагов: \(steps)"
        
        imageNames.shuffle()
        
        
        count = 0
        
        for i in 1...16 {
            
            let button = view.viewWithTag(i) as! UIButton
            
            button.setBackgroundImage(nil, for: .normal)
        }
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "WIN!!!", message: "Play again?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ _ in
            self.clear()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func game(_ sender: UIButton) {
        
        if isTimerEnabled == true {
            return
        }
        
        if sender.backgroundImage(for: .normal) != nil {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: imageNames[sender.tag - 1]), for: .normal)
            
        if isOpened == true {
            steps += 1
            
            
            if imageNames[sender.tag - 1] == imageNames[previousButtonTag - 1] {
                count += 1
                
            } else {
                isTimerEnabled = true
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    
                    sender.setBackgroundImage(nil, for: .normal)
                    
                    let previousButton = self.view.viewWithTag(self.previousButtonTag) as! UIButton

                    previousButton.setBackgroundImage(nil, for: .normal)
                    
                    self.isTimerEnabled = false
                    
                    self.stepCountLabel.text = "количество шагов: \(self.steps)"
                }
            }
            
        } else {
            previousButtonTag = sender.tag // 1
        }
        
        
        //stepCountLabel.text = "Количество шагов:  \(steps)"
        
        
                                     
         isOpened.toggle()
        
        if count == 8 {
            showAlert()
        }
    }
    
}

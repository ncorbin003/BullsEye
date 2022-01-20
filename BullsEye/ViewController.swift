//
//  ViewController.swift
//  BullsEye
//
//  Created by Nicola Corbin on 1/16/22.
//

import UIKit
import WebKit

//The job of a view controller, generally, is to manage a single screen in your app.
class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOver()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(
          named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        // Do any additional setup after loading the view.
    }

    //lets Interface Builder know that the controller has a “showAlert” action, which presumably will show an alert pop-up
    @IBAction func showAlert() {
      let difference = abs(targetValue - currentValue)
      var points = 100 - difference
      

      // add these lines
      let title: String
      if difference == 0 {
        title = "Perfect!"
        points += 100
      } else if difference < 5 {
        title = "You almost had it!"
          if difference == 1 {            // add these lines
            points += 50                  // add these lines
          }
      } else if difference < 10 {
        title = "Pretty good!"
      } else {
        title = "Not even close..."
      }
        score += points

      let message = "You scored \(points) points"

      let alert = UIAlertController(
        title: title,  // change this
        message: message,
        preferredStyle: .alert)

      let action = UIAlertAction(
        title: "OK",
            style: .default,
            handler: { _ in
              self.startNewRound()
            })

      alert.addAction(action)
      present(alert, animated: true, completion: nil)

    }
    
    @IBAction func startOver() {
        round = 0
        score = 0
        startNewRound()
        
          // Add the following lines
          let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
    }

    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
   
    
    func startNewRound() {
      round += 1
      targetValue = Int.random(in: 1...100)
      currentValue = 50
      slider.value = Float(currentValue)
      updateLabels()
    }
    
    func updateLabels() {
      targetLabel.text = String(targetValue)
      scoreLabel.text = String(score)
      roundLabel.text = String(round)
    }
}

// (If you are curious, you can check the connection between the screen and the code for it by switching to the Identity inspector on the right sidebar of Xcode in the storyboard view. The Class value shows the current class associated with the storyboard scene

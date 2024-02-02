//
//  ViewController.swift
//  CatsAndMice
//
//  Created by Megan Schmoyer on 1/30/24.
//

import UIKit

class ViewController: UIViewController {
    // Dependency Inversion Principle created instance which can be passed off to the Animal Protocol
    @IBOutlet weak var winResults: UILabel!
    @IBOutlet weak var mouseDistanceLabel: UILabel!
    @IBOutlet weak var catDistanceLabel: UILabel!
    
    
    var cat: Runnable?
        var mouse: Runnable?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            cat = Cat()
            mouse = Mouse()
            winResults.isHidden = true
            mouseDistanceLabel.isHidden = true
            catDistanceLabel.isHidden = true
        }
    
    @IBAction func mouseRunButtonPressed(_ sender: UIButton) {
        guard let mouse = mouse else {
                 print("Mouse is not initialized")
                 return
             }
             let mouseDistance = mouse.run()
        mouseDistanceLabel.text = "Mouse Distance: \(mouseDistance)"
        mouseDistanceLabel.isHidden = false
             print("Mouse distance after run: \(mouseDistance)")
             if let noiseMaker = mouse as? NoiseMaker {
                 let noiseMade = noiseMaker.makeNoise()
                 if noiseMade {
                     print("Mouse made a noise")
                 } else {
                     print("Mouse did not make a noise")
                 }
             }
             checkCatch()
         }
    //Liskov Substitution run() function is called from cat which is called from Animal
    @IBAction func catRunButtonPressed(_ sender: UIButton) {
        guard let cat = cat else {
                  print("Cat is not initialized")
                  return
              }
              let catDistance = cat.run()
        catDistanceLabel.text = "Cat Distance: \(catDistance)"
        catDistanceLabel.isHidden = false
              print("Cat distance after run: \(catDistance)")
              if let noiseMaker = cat as? NoiseMaker {
                  let noiseMade = noiseMaker.makeNoise()
                  if noiseMade {
                      print("Cat made a noise")
                  } else {
                      print("Cat did not make a noise")
                  }
              }
              checkCatch()
          }
    
    //Open/Closed Principle can be added to but not modified
    func checkCatch() {
        guard let mouse = mouse, let cat = cat else {
               print("Mouse or Cat is not initialized")
               return
           }
           
           if mouse.distance >= 30.0 {
               resetDistance()
               winResults.text = "Mouse Escaped"
               winResults.isHidden = false
               print("Mouse escaped!")
           } else if mouse.distance != 0 && cat.distance != 0 && mouse.distance == cat.distance {
               resetDistance()
               winResults.text = "Cat caught the mouse"
               winResults.isHidden = false
               print("Cat caught the mouse!")
           }
       }
    
    func resetDistance() {
           cat?.distance = 0.0
           mouse?.distance = 0.0
        
        mouseDistanceLabel.text = "Mouse Distance: 0.0"
        catDistanceLabel.text = "Cat Distance: 0.0"
       }
    
    }

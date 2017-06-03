//
//  ViewController.swift
//  OldWayCalculator
//
//  Created by Junaid Khan on 02/06/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var outPutLabel: UILabel!
    var btnSound : AVAudioPlayer!
    
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case subtract = "-"
        case Empty = "Empty"
    }
    
    var runningNumber =  ""
    var lefthandValue  = ""
    var righthandValue = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: ".wav")
        let soundURL = URL(fileURLWithPath: path!)
        outPutLabel.text = "0"
      
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
       
    }
    @IBAction func buttonPressed(sender: UIButton)
    {
        playAudio()
        runningNumber += "\(sender.tag)"
        outPutLabel.text = runningNumber
    }
    func playAudio()
    {
        if btnSound.isPlaying
        {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject)
    {
        processOpertion(operation: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject)
    {
        processOpertion(operation: .Multiply)
    }
    @IBAction func onAddPressed(sender: AnyObject)
    {
        processOpertion(operation: .Add)
    }
    @IBAction func onSubtratcPressed(sender: AnyObject)
    {
        processOpertion(operation: .subtract)
    }
    @IBAction func onEqualPressed(sender: AnyObject)
    {
        processOpertion(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: Any) {
        runningNumber = ""
        result = ""
        outPutLabel.text = result
        processOpertion(operation: .Empty)
        
        
    }
    func processOpertion (operation: Operation)
    {
        if currentOperation != Operation.Empty
        {
            if runningNumber != ""
            {
                righthandValue = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide
                {
                    result = "\(Double(lefthandValue)! / Double(righthandValue)!)"
                }
                else if currentOperation == Operation.Multiply
                {
                    result = "\(Double(lefthandValue)! * Double(righthandValue)!)"
                }
                else if currentOperation == Operation.Add
                {
                    result = "\(Double(lefthandValue)! + Double(righthandValue)!)"
                }
                else if currentOperation == Operation.subtract
                {
                    result = "\(Double(lefthandValue)! - Double(righthandValue)!)"
                }
                lefthandValue = result
                outPutLabel.text = result
            }
            currentOperation = operation
        }
        else
        {
            lefthandValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}


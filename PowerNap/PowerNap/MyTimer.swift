//
//  MyTimer.swift
//  PowerNap
//
//  Created by Eric Andersen on 8/27/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    func timerSecondTicked()
    func timerStopped()
    func timerCompleted()
}

class MyTimer {
    
    private var timer: Timer?
    weak var delegate: MyTimerDelegate?
    
    // time left
    var timeLeft: TimeInterval?
    
    // timer is on
    var isOn: Bool {
        if timeLeft == nil {
            return false
        } else {
            return true
        }
    }
    
    // func start timer
    func startTimer(_ time: TimeInterval) {
        if isOn {
            print("Mistake was made, timer should not be re-started")
        } else {
            timeLeft = time
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_)  in
                self.secondTicked()
            })
        }
    }
    
    // func stop timer
    func stopTimer() {
        self.timeLeft = nil
        timer?.invalidate()
        print("stop timer")
        delegate?.timerStopped()
    }
    
    // time left as string
    func timeLeftAsString() -> String {
        let timeRemaining = Int(self.timeLeft ?? 20 * 60)
        let minutesLeft = timeRemaining / 60
        let secondsLeft = timeRemaining - (minutesLeft * 60)
        return String(format: "%02d : %02d", arguments: [minutesLeft, secondsLeft])
    }
    
    // private method that will determine what should happen when a second ticks by
    func secondTicked() {
        
        // check to see how much time is left
        guard let timeLeft = timeLeft else {
            print("someone forgot to set the time left")
            return
        }
        
        // if it's greateer than zero, reduce by 1
        if timeLeft > 0 {
            self.timeLeft = timeLeft - 1
            print(self.timeLeftAsString())
            delegate?.timerSecondTicked()
        } else {
            // otherwise stop the timer
            self.timeLeft = nil
            timer?.invalidate()
            print("stop timer")
            delegate?.timerCompleted()
        }
    }
}















































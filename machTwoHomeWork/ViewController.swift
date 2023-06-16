//
//  ViewController.swift
//  machTwoHomeWork
//
//  Created by Ернат on 19.05.2023.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    var state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var images = ["camel", "cat", "dog", "ears", "julian", "otter", "parrot", "sheep", "camel", "cat", "dog", "ears", "julian", "otter", "parrot", "sheep"]
    
    var winArray = [[0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14], [7, 15]]
    
    var isGaming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        images.shuffle()
        winArray.removeAll()
        for i in 0...15 {
            for j in 0...15 {
                if images[i] == images[j] && i != j {
                    winArray.append([i, j])
                }
            }
        }
    }
    
    @IBAction func game(_ sender: UIButton) {
        
        if state[sender.tag - 1] != 0 || isGaming {
            return
        }
        
        state[sender.tag - 1] = 1
        
        sender.setBackgroundImage(UIImage(named: images[sender.tag - 1]), for: .normal)
        
        sender.backgroundColor = .clear
        
        for wins in winArray {
            if state[wins[0]] == 1 && state[wins[1]] == 1 {
                state[wins[0]] = 2
                state[wins[1]] = 2
            }
        }
        
        var count1 = 0
        var count2 = 0
        for i in 0...15 {
            if state[i] == 1 {
                count1 += 1
            }
            if state[i] == 2 {
                count2 += 1
            }
        }
        if count1 == 2 {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
            isGaming = true
        }
        if count2 == 16 {
            let alert = UIAlertController(title: "You win!", message: "You win!", preferredStyle: .alert)
            
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.clearAll()
            })
            
            alert.addAction(alertaction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func clear() {
        isGaming = false
        for i in 0...15 {
            if state[i] == 1 {
                let button = view.viewWithTag(i + 1) as! UIButton
                button.setBackgroundImage(nil, for: .normal)
                button.backgroundColor = .systemTeal
                state[i] = 0
            }
        }
    }
    
    func clearAll() {
        isGaming = false
        for i in 0...15 {
            let button = view.viewWithTag(i + 1) as! UIButton
            button.setBackgroundImage(nil, for: .normal)
            button.backgroundColor = .systemTeal
            state[i] = 0
        }
    }
    
}


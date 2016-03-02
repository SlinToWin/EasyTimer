//
//  ViewController.swift
//  EasyTimer
//
//  Created by Niklas Fahl on 3/2/16.
//  Copyright © 2016 High Bay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        2.second.interval {
            print("repeating every two seconds")
        }
        
        let timer = 2.second.delayedInterval { () -> Void in
            print("delayed repeat")
        }
        timer.cancel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
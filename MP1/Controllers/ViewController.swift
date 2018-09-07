//
//  ViewController.swift
//  MP1
//
//  Created by Vaibhav Gattani on 6/9/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var StartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createButton() {
        StartButton = UIButton(frame: CGRect(x: 10, y: 10, width: view.frame.width, height: 100))
        StartButton.setTitle("START", for: .normal)
        StartButton.setTitleColor(UIColor.white, for: .normal)
        StartButton.backgroundColor = UIColor.black
        StartButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        view.addSubview(StartButton)
    }
    
    @objc func buttonClick() {
        performSegue(withIdentifier: "Start", sender: self)
        
    }

}


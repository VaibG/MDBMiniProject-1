//
//  StartViewController.swift
//  MP1
//
//  Created by Vaibhav Gattani on 6/9/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var StartButton: UIButton!
    var matchTheMembers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton()
        createLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createButton() {
        StartButton = UIButton(frame: CGRect(x: 20, y: 2 * view.frame.height/3, width: view.frame.width - 40, height: 50))
        StartButton.setTitle("START", for: .normal)
        StartButton.setTitleColor(UIColor.white, for: .normal)
        StartButton.backgroundColor = UIColor.black
        StartButton.layer.cornerRadius = 20
        StartButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        view.addSubview(StartButton)
    }
    
    func createLabel() {
        matchTheMembers = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 300))
        matchTheMembers.text = "Welcome to \n Match the Members"
        matchTheMembers.font = UIFont(name: matchTheMembers.font.fontName, size: 34.0)
        matchTheMembers.numberOfLines = 0
        matchTheMembers.textAlignment = .center
        view.addSubview(matchTheMembers)
    }
    
    @objc func buttonClick() {
        performSegue(withIdentifier: "Start", sender: self)
    }
    
}


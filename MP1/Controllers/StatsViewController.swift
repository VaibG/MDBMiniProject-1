//
//  StatsViewController.swift
//  MP1
//
//  Created by Vaibhav Gattani on 8/9/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var streak : Int!
    var results : [String]! = []
    var streakLabel : UILabel!
    var resultsLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createStats()
    }
    
    func createStats(){
        streakLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        streakLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 100)
        streakLabel.text = "Longest Streak: \(streak!)"
        streakLabel.textAlignment = .center
        view.addSubview(streakLabel)
        
        resultsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        resultsLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 + 100)
        if results.count == 3 {
            resultsLabel.text = "Last Three Results: \(results[0]), \(results[1]), \(results[2])"
        } else if results.count == 2 {
            resultsLabel.text = "Last Three Results: \(results[0]), \(results[1])"
        } else if results.count == 1 {
            resultsLabel.text = "Last Three Results: \(results[0])"
        } else {
            resultsLabel.text = "Last Three Results: N/A"
        }
        resultsLabel.textAlignment = .center
        view.addSubview(resultsLabel)
    }

}

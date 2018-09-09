//
//  MainViewController.swift
//  MP1
//
//  Created by Vaibhav Gattani on 7/9/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var RandomPic : UIImageView!
    var Options : [UIButton] = []
    var ButtonY : CGFloat!
    var ButtonX : CGFloat!
    var correctIndex : Int!
    var scoreLabel : UILabel!
    var score : Int! = 0
    var timer = Timer()
    var time = 0
    var StartButton : UIButton!
    var firstRun = true
    var timeLabel : UILabel!
    var streak : Int! = 0
    var results : [String]! = []
    var largestStreak : Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startButton()
        if firstRun {
            createScore()
            createOption()
            createImage()
            correctIndex = setImage()
            setName(correctIndex)
            firstRun = false
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeIncrement), userInfo: nil, repeats: true)
        }
        let statistics = UIBarButtonItem(image: #imageLiteral(resourceName: "Stats"), style: .plain, target: self, action: #selector(Statistics))
        self.navigationItem.rightBarButtonItem = statistics
    }
    
    func createOption() {
        ButtonY = 2*view.frame.height/3 - 20
        ButtonX = CGFloat(10)
        
        for i in 0..<4 {
            Options.append(UIButton(frame: CGRect(x: ButtonX, y: ButtonY, width: view.frame.width/2 - 20, height: 50)))
            let x = Options[i]
            x.backgroundColor = UIColor.black
            x.layer.cornerRadius = 20
            x.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            view.addSubview(x)
            if ButtonX == CGFloat(10)
            {
                ButtonX = ButtonX + view.frame.width/2
            } else {
                ButtonX = CGFloat(10)
                ButtonY = ButtonY + 70
            }

        }
    }
    
    func createImage() {
        RandomPic = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.addSubview(RandomPic)
    }
    
    func setImage() -> Int {
        let x = arc4random_uniform(UInt32(Constants.names.count))
        RandomPic.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3)
        RandomPic.contentMode = .scaleAspectFit
        RandomPic.image = Constants.getImageFor(name: Constants.names[Int(x)])
        return Int(x)
    }
    
    func setName(_ pictureIndex: Int){
        let x = arc4random_uniform(4)
        for i in 0..<4 {
            if x == i {
                Options[i].setTitle(Constants.names[pictureIndex], for: .normal)
                Options[i].tag = pictureIndex
            } else {
                let rand = getRand()
                Options[i].setTitle(Constants.names[rand], for: .normal)
                Options[i].tag = rand
            }
            Options[i].setTitleColor(UIColor.white, for: .normal)

        }
    }
    
    func getRand() -> Int {
        let rand = arc4random_uniform(UInt32(Constants.names.count))
        for x in Options {
            if x.currentTitle == Constants.names[Int(rand)] {
            return getRand()
            }
        }
        return Int(rand)
    }
    
    func createScore(){
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        scoreLabel.center = CGPoint(x: view.frame.width/4, y: view.frame.height-50)
        scoreLabel.text = "Score: \(score!)"
        scoreLabel.textAlignment = .center
        scoreLabel.font.withSize(28.0)
        view.addSubview(scoreLabel)
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        timeLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height-50)
        timeLabel.text = String(time)
        timeLabel.textAlignment = .center
        timeLabel.font.withSize(28.0)
        view.addSubview(timeLabel)
    }
    
    func isCorrect(_ selected: Int) -> Bool {
        if selected == correctIndex {
            if StartButton.currentTitle == "STOP"{
                score = score + 1
                scoreLabel.text = "Score: \(score!)"
                streak = streak + 1
                if streak > largestStreak {
                    largestStreak = streak
                }
                return true
            }
        }
        streak = 0
        scoreLabel.text = "Score: \(score!)"
        return false
    }
    
    func startButton() {
        StartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        if firstRun {
            StartButton.setTitle("STOP", for: .normal)
        } else {
            StartButton.setTitle("START", for: .normal)
        }
        StartButton.center = CGPoint(x: 3*view.frame.width/4, y: view.frame.height-50)
        StartButton.backgroundColor = UIColor.black
        StartButton.layer.cornerRadius = 20
        StartButton.addTarget(self, action: #selector(startClicked), for: .touchUpInside)
        view.addSubview(StartButton)
        
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        for x in Options {
            x.isEnabled = false
        }
        time = 0
        timeLabel.text = String(time)
        let correct = isCorrect(sender.tag)
        if correct {
            sender.backgroundColor = UIColor.green
            results.append("Correct")
        } else {
            sender.backgroundColor = UIColor.red
            results.append("Wrong")
        }
        if results.count > 3 {
            results.removeFirst()
        }
        
    }
    
    @objc func timeIncrement() {
        time = time + 1
        if time == 6 {
            time = 0
            correctIndex = setImage()
            setName(correctIndex)
            results.append("Wrong")
            if results.count > 3 {
                results.removeFirst()
            }
            streak = 0
        }
        if time == 1 {
            for x in Options {
                if x.backgroundColor != UIColor.black {
                    x.backgroundColor = UIColor.black
                    time = 0
                    correctIndex = setImage()
                    setName(correctIndex)
                }
                x.isEnabled = true
            }
        }
        timeLabel.text = String(time)
        
    }
    @objc func startClicked(_ sender: UIButton) {
        
        if sender.currentTitle == "START"{
            sender.setTitle("STOP", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeIncrement), userInfo: nil, repeats: true)

        } else {
            sender.setTitle("START", for: .normal)
            timer.invalidate()
        }
    }
    
    @objc func Statistics() {
        performSegue(withIdentifier: "stats", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let StatsVC = segue.destination as! StatsViewController
        StatsVC.streak = largestStreak
        StatsVC.results = results
        timer.invalidate()
    }

}

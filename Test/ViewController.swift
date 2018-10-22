//
//  ViewController.swift
//  Test
//
//  Created by Navneet Singh Kandara on 9/4/17.
//  Copyright © 2017 Cogniter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SegmentedControlViewDelegate {

    
    @IBOutlet weak var switchCheckButton: SwitchCheckBtn!
    
    @IBOutlet weak var backProgressBtn: UIButton!

    @IBOutlet weak var backGroundImage: UIImageView!
   
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var seg: SegmentedControlView!
    
    @IBOutlet weak var progressBarView: NSKProgressCheckBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        backProgressBtn.clipsToBounds = true
        backProgressBtn.layer.cornerRadius = backProgressBtn.bounds.width/2
        backProgressBtn.layer.borderWidth = 1.0
        backProgressBtn.layer.borderColor = UIColor.blue.cgColor
        // Do any additional setup after loading the view, typically from a nib.
        seg.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myLabel.text = seg.segmentTextArray[0]
        backGroundImage.image = UIImage(named: "\(seg.segmentTextArray[seg.selectedSegment]).jpg")
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentedControlView(_ segmentedControlView: SegmentControlView, selectedSegment: Int, previousSegment: Int) {
        myLabel.text = seg.segmentTextArray[seg.selectedSegment]
        backGroundImage.image = UIImage(named: "\(seg.segmentTextArray[seg.selectedSegment]).jpg")
    }
    
    @IBAction func nextCheckPoint(_ sender: Any) {
        progressBarView.nextStep()
    }
    
    @IBAction func previousCheckPoint(_ sender: Any) {
        progressBarView.previousStep()
    }
    
    deinit {
        self.seg.removeObserver(self, forKeyPath: "selectedSegment")
    }
}


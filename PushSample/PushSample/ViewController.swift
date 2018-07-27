//
//  ViewController.swift
//  PushSample
//
//  Created by m2comm on 2018. 7. 26..
//  Copyright © 2018년 wlsrn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(frame: CGRect(x: 10, y: STATUS_BAR_HEIGHT + 10, width: 50, height: 50))
        button.backgroundColor = UIColor.randomColor()
        button.addTarget(event: .touchUpInside) { (button) in
            print("buttonPressed")
            NotiCenter.shared.addAlram(time: Date(timeIntervalSinceNow: 60), complete: { (success : Bool) in
                if !success { print("failed")}
                else { print("success") }
            })
        }
        self.view.addSubview(button)
        
        
        
        
        let button2 = UIButton(frame: CGRect(x: 10, y: button.frame.maxY + 20, width: 50, height: 50))
        button2.backgroundColor = UIColor.randomColor()
        button2.addTarget(event: .touchUpInside) { (button) in
            NotiCenter.shared.readAlram(identifiers: "sampleID")
        }
        self.view.addSubview(button2)
        
        
        if let sampleImage = UIImage(contentsOfFile: "sampleImage") {
            let imageView = UIImageView(frame: CGRect(x: 0, y: button2.frame.maxX + 10, width: SCREEN.WIDTH, height: 0))
            imageView.setImageWithFrameHeight(image: sampleImage)
            self.view.addSubview(imageView)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


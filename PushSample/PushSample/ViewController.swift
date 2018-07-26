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
        
        let targetImage = #imageLiteral(resourceName: "kakao")
        let imageName = "kakao"
        
        //save
        let _ = targetImage.saveImageToDocuments(fileName: imageName)
        
        //read
//        let afterImage = UIImage.readImageFromeDocuments(fileName: imageName)
        let afterImage = UIImage(documentFileName: imageName)
        
        self.view.addSubview(UIImageView(image: afterImage))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


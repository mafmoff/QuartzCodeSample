//
//  ViewController.swift
//  QuartzCodeSample
//
//  Created by SaikaYamamoto on 2017/01/24.
//  Copyright © 2017年 mafmoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.addLoadingAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

